
class Api::UsersController < Api::ApiController

  before_action :set_config

  ## @TODO: actually not used, users#show is used?
=begin
  def fb_sign_in
    authorize! :fb_sign_in, Ability
    params.permit!
    
    access_token = params[:accessToken]
    email        = params[:email]
    name         = params[:name]
    user         = User.where( :email => email ).first
    passwd       = (0..8).map { "#{rand(100)}" }.join("#{rand(100)}")

    @profile                 = Profile.find_or_create_by :email => email
    @profile.fb_access_token = access_token
    @profile.name          ||= name
    @profile.user          ||= user
    @profile.email         ||= email
    @profile.user          ||= User.create( :email => email, :password => passwd )

    auth                   = Koala::Facebook::OAuth.new( app_id, app_secret, "//localhost:3001" )
    @profile.fb_long_access_token = auth.exchange_access_token access_token

    if @profile.save
      render
    else
      render :json => { :status => :not_ok, :errors => @profile.errors.messages }
    end
  end
=end

  def show
    authorize! :fb_sign_in, Ability
    begin
      @graph            = Koala::Facebook::API.new( params[:accessToken] )
      me                = @graph.get_object( 'me', :fields => 'email' )
      @user             = User.find_or_create_by :email => me['email']
      @oauth            = Koala::Facebook::OAuth.new( @app_id, @app_secret )

      byebug

      signed_request    = @oauth.parse_signed_request( params[:signedRequest] )
      begin
        @long_lived_token = @oauth.get_access_token signed_request['code']
      rescue Koala::Facebook::OAuthTokenRequestError
      end

      begin
        @profile      = Profile.find_or_create_by :email => me['email']
        @profile.update_attributes({ :fb_access_token => @long_lived_token,
                                     :fb_long_access_token => @long_lived_token })
      rescue Mongoid::Errors::DocumentNotFound
        @profile    = Profile.create :user => @user, :email => me['email'],
                                     :fb_access_token => @long_lived_token,
                                     :fb_id           => params[:id],
                                     :name            => params[:name],
                                     :signed_request  => params[:signedRequest]
      end
      render :action => 'fb_sign_in'
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
  
  #
  # private
  #
  private

  def set_config
    @config     = YAML.load( File.read( Rails.root.join('config', 'koala.yml') ) )[Rails.env]
    @app_id     = @config['app_id']
    @app_secret = @config['app_secret']
  end

end
