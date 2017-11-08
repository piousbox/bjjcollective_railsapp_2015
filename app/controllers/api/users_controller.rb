
class Api::UsersController < Api::ApiController

  before_action :set_profile 

  # profile
  def show
    authorize! :fb_sign_in, Ability

    render :action => 'fb_sign_in'
  end
  
  def fb_sign_in
    authorize! :fb_sign_in, Ability
    puts! params, 'fb_sign_in params'

    begin
      @profile = Profile.find_by :email => @me['email']
    rescue Mongoid::Errors::DocumentNotFound
      @profile = Profile.create :user => @user, :email => @me['email'],
                                :fb_long_access_token  => @long_lived_token,
                                :fb_id                 => params[:id],
                                :name                  => params[:name],
                                :signed_request        => params[:signedRequest]
    end
  end

  # profile update
  def update
    authorize! :fb_sign_in, Ability

    @long_token = get_long_token

    begin
      @graph        = Koala::Facebook::API.new( @long_token )
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
  # see api_controller
  #
  private

end
