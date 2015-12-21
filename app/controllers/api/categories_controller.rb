
class Api::CategoriesController < Api::ApiController

  layout false

  def index
    @categories = Category.where( :category_id => nil )
  end

  def index_shallow      
    if params[:slug]
      @category = Category.where( :slug => params[:slug] ).first
      if params[:slug_1]
        @category = Category.where( :short_slug => params[:slug_0], :category_id => @category.id ).first
        @category = Category.where( :short_slug => params[:slug_1], :category_id => @category.id ).first
      end
      @categories = Category.where( :category_id => @category.id )
    else
      @categories = Category.where( :category_id => nil )
    end
  end
  
end

