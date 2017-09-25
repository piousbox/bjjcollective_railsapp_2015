class Api::ApiController < ApplicationController
  layout :false
  protect_from_forgery :with => :null_session
  def home
    render :json => { :status => :ok }
  end
  
end
