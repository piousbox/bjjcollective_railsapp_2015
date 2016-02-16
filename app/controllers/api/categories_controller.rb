
class Api::CategoriesController < Api::ApiController

  layout false

  def index
    @categories = Category.where( :category_id => nil )
  end

  def show
    slugs = params[:all].split('/')
    @category = Category.where( :category_id => nil, :short_slug => slugs[0] ).first
  end

  
  def index_shallow
    if params[:slug]
      @category = Category.where( :slug => params[:slug] ).first
      # puts! @category
      
      if params[:slug_1]
        @category = Category.where( :short_slug => params[:slug_0], :category_id => @category.id ).first
        @category = Category.where( :short_slug => params[:slug_1], :category_id => @category.id ).first
        if params[:slug_3]
          @category = Category.where( :short_slug => params[:slug_2], :category_id => @category.id ).first
          @category = Category.where( :short_slug => params[:slug_3], :category_id => @category.id ).first
          @n_videos = @category.videos.length
          @videos = @category.videos.page( params[:videos_page] ).per( 10 )
          @n_pages = ( @category.videos.length.to_f / 10 ).ceil
        end
      end
      @categories = Category.where( :category_id => @category.id )
    else
      @categories = Category.where( :category_id => nil )
    end
  end

  def index_by_path
    path = URI.decode( params[:path]||'' ).split '/'
    @categories = Category.where( :category_id => nil ).to_a
    @categories.each do |category|
      if 'simple' == category.kind
        category.categories = Category.where( :category_id => category.id )
      end
    end
  end
  
end

