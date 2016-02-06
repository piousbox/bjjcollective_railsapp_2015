
class Api::ApiController < ApplicationController

  def home
    render :json => :ok
  end
  
end
