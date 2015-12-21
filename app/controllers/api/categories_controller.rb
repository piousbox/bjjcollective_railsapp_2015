
class Api::CategoriesController < Api::ApiController

  layout false

  def index
    @categories = Category.where( :category_id => nil )
  end

  def index_shallow
    @categories = Category.where( :category_id => nil )
    if params[:slug]
      category = Category.where( :slug => params[:slug] ).first
      @categories = Category.where( :category_id => category.id )
    end
  end
  
end

