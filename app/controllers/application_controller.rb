
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def puts! args, label=""
    puts "+++ +++ #{label}"
    puts args.inspect
  end

  def ads_enabled?
    true
  end
  
end
