
class Manager::ManagerController < ApplicationController

  before_filter :authenticate

  layout 'manager'
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "bjjc" && password == "technique-conquers-all"
    end
  end
  
end
