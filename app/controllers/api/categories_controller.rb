
class Api::CategoriesController < Api::ApiController

  layout false

  def index
    @categories = Category.where( :category_id => nil )
  end

  def index_shallow
    @categories = Category.where( :category_id => nil )
  end
  
end

