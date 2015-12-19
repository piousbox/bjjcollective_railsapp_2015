
class CategoriesController < ApplicationController

  def index
    @categories = []
    render :index_2
  end

  def show_legacy
    @category = CategoryLegacy.find_by_url_name( params[:id] )
    @videos = @category.video_legacies.paginate( :page => params[:page], :per_page => 10 )
  end

  def show
    @categories = Category.where( :category => nil )
    @category = Category.where( :slug => params[:slug] ).first
    create_categories_list @category
    @videos = @category.videos.page( params[:videos_page] ).per( 10 )
  end

end

