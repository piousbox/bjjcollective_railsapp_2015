
class WelcomeController < ApplicationController

  def home
    redirect_to fg_root_path and return
    
    # respond_to do |format|
    #   format.html do
    #     render
    #   end
    #   format.json do
    #     render :json => { :status => :ok }
    #   end
    # end
    
  end

end
