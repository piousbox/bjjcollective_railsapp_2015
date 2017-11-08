class Api::ApiController < ApplicationController
  layout :false
  protect_from_forgery :with => :null_session
  before_action :set_config
  # before_action :set_profile
  check_authorization

  def home
    render :json => { :status => :ok }
  end
  
  #
  # private
  #
  private 

  def set_profile
    accessToken   = request.headers[:accessToken]
    accessToken ||= params[:fb_long_access_token]
    accessToken ||= params[:accessToken] # if (params[:debug] == 'abba' && Rails.env.development?)
    # byebug
    if accessToken
      begin
        @graph            = Koala::Facebook::API.new( accessToken )
        @me               = @graph.get_object( 'me', :fields => 'email' )
        @user             = User.find_or_create_by :email => @me['email']
        @oauth            = Koala::Facebook::OAuth.new( @app_id, @app_secret )
        @long_lived_token = accessToken # get_long_token( accessToken )

        begin
          @profile = Profile.find_by :email => @me['email']
          # @profile.update_attributes({ :fb_access_token      => @long_lived_token,
          #                              :fb_long_access_token => @long_lived_token })
        rescue Mongoid::Errors::DocumentNotFound
          @profile = Profile.create :user => @user, :email => @me['email'],
                                    # :fb_access_token       => @long_lived_token,
                                    :fb_long_access_token  => @long_lived_token,
                                    :fb_id                 => params[:id],
                                    :name                  => params[:name],
                                    :signed_request        => params[:signedRequest]
        end
        @current_user    = @user
        @current_profile = @profile
      rescue Koala::Facebook::AuthenticationError => e
        render :json => { :status => :not_ok, :errors => "Probably expired token: #{accessToken}" }
        return
      end
    end
  end

  def get_long_token accessToken
    url = "https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&" +
          "client_id=#{@config['app_id']}&client_secret=#{@config['app_secret']}&fb_exchange_token=#{accessToken}"
    result = HTTParty.get url
    token = JSON.parse result.body
    return token['access_token']
  end

  def set_config
    @config     = YAML.load( File.read( Rails.root.join('config', 'koala.yml') ) )[Rails.env]
    @app_id     = @config['app_id']
    @app_secret = @config['app_secret']
  end

end
