
class Api::UsersController < Api::ApiController

    def fb_sign_in
      authorize! :fb_sign_in, Ability
      params.permit!

      access_token = params[:accessToken]
      email        = params[:email]
      name         = params[:name]
      user         = User.where( :email => email ).first

      u                 = Profile.find_or_create_by :email => email
      u.fb_access_token = access_token
      u.name          ||= name
      u.user          ||= user
      u.email         ||= email
      u.user          ||= User.create( :email => email, :password => (0..8).map { "#{rand(100)}" }.join("#{rand(100)}") )

      auth                   = Koala::Facebook::OAuth.new
      u.fb_long_access_token = auth.exchange_access_token access_token

      puts! u, 'profile, here'

      if u.save
        render :json => { :status => :ok, :profile => u }
      else
        render :json => { :status => :not_ok, :errors => u.errors.messages }
      end
    end

    def show
      authorize! :fb_sign_in, Ability
      begin
        @graph        = Koala::Facebook::API.new( params[:accessToken] )
        me            = @graph.get_object( 'me', :fields => 'email' )
        @user         = User.find_by                   :email => me['email']
        @user_profile = Profile.find_by :email => me['email']
      rescue Koala::Facebook::AuthenticationError => e
        render :json => { :status => :not_ok, :errors => "Probably expired token." }
        return
      end
    end

    def update
      authorize! :fb_sign_in, Ability

      begin
        @graph        = Koala::Facebook::API.new( params[:accessToken] )
        me            = @graph.get_object( 'me', :fields => 'email' )
        @user         = User.find_by( :email => me['email'] )
        @user_profile = Profile.find_by :email => me['email']
        flag          = @user_profile.update_attributes( params[:user_profile].permit( :about, :current_city_id ) )
        @errors       = @user_profile.errors.messages
      rescue Koala::Facebook::AuthenticationError => e
        flag = false
        @errors = "Probably expired token."
      end

      if flag
        render :json => { :status => :ok }
      else
        render :json => { :status => :not_ok, :errors => @errors }
      end
    end

end
