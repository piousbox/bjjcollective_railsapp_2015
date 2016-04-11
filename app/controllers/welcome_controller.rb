
class WelcomeController < ApplicationController

  def home
    authorize! :home, Ability
    redirect_to :controller => "fighters_guild/questpages", :action => "index"
  end

end
