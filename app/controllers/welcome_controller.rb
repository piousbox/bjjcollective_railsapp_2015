
class WelcomeController < ApplicationController

  def home
    redirect_to :controller => "technique/categories", :action => "home"
  end

end
