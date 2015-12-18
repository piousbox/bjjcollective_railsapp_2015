
class WelcomeController < ApplicationController

  def home
    @categories = Category.where( :category => nil )
     
    respond_to do |format|
      format.html do
        render
      end
      format.json do
        render :json => { :status => :ok }
      end
    end
    
  end

end
