class Api::ApiController < ApplicationController
  layout :false

  def home
    render :json => { :status => :ok }
  end
  
end
