
class Api::VideosController < Api::ApiController

  layout false

  def index
    @categories = Category.where( :category_id => nil )
    @category = Category.find params[:category_id]
    @videos = @category.videos.page( params[:videos_page]||0 ).per( 20 )
  end

  def show_one
    if params[:id]
      @video = Video.find params[:id]
    elsif params[:youtube_id]
      @video = Video.find_by :youtube_id => params[:youtube_id]
    end
  end
  
  def show
    slugs = params[:all].split('/')
    @category = Category.where( :category_id => nil, :short_slug => slugs[0] ).first
  end

  def show_simple_expanded
    @path = URI.decode( params[:path]||'' ).split '/'    
    if params[:id]
      @category = Category.find params[:id]
      @categories = @category.categories
    else
      @category = nil
      @categories = Category.where( :category_id => nil )
    end
    render 'index_by_path'
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
    @path = URI.decode( params[:path]||'' ).split '/'
    @categories = Category.where( :category_id => nil )

    temp_path = @path
    @category = Category.where( :category_id => nil, :short_slug => temp_path[0] ).first
    temp_path = temp_path.drop( 1 )
    while temp_path.length > 0
      @category = @category.categories.where( :short_slug => temp_path[0] ).first
      temp_path = temp_path.drop( 1 )
    end
   
  end
  
end

