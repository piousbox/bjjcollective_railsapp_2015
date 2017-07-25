class Manager::SitemapsController < ApplicationController
  def show
    respond_to do |format|
      format.xml do
        @prefix = "http://bjjcollective.com/technique"

        @category = Category.where( :category => nil ).first
        @categories = @category.categories
        render :layout => false
      end
    end
  end
end
