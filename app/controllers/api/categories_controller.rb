class Api::CategoriesController < Api::ApiController

  def index
    @categories = Category.where( :category_id => nil )
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
      # puts! @category, 'category'
      
      if params[:slug_0]
        @category = Category.where( :short_slug => params[:slug_0], :category_id => @category.id ).first
        if params[:slug_1]
          @category = Category.where( :short_slug => params[:slug_1], :category_id => @category.id ).first
          if params[:slug_2]
            @category = Category.where( :short_slug => params[:slug_2], :category_id => @category.id ).first 
            if params[:slug_3]
              @category = Category.where( :short_slug => params[:slug_3], :category_id => @category.id ).first
            end
          end
        end
      end
      @n_videos = @category.videos.length
      @videos = @category.videos.page( params[:videos_page] ).per( 6 )
      @n_pages = ( @category.videos.length.to_f / 10 ).ceil
      @categories = Category.where( :category_id => @category.id )
    else
      @category = Category.new :title => 'Technique', :slug => 'technique', :short_slug => 'technique', :path => '/'
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

