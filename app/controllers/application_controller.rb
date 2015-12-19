
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

  def create_categories_list c
    @categories_list = [ c ]
    while c.category
      @categories_list.unshift c.category
      c = c.category
    end
  end
  
end
