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
    @category = Category.find_or_create_by :title => 'Technique'

    if params[:slug]
      @category = Category.where( :short_slug => params[:slug], :catgegory_id => @category_id ).first      
      if params[:slug_0]
        @category = Category.where( :short_slug => params[:slug_0], :category_id => @category.id ).first
        if params[:slug_1]
          @category = Category.where( :short_slug => params[:slug_1], :category_id => @category.id ).first
          if params[:slug_2]
            @category = Category.where( :short_slug => params[:slug_2], :category_id => @category.id ).first 
            if params[:slug_3]
              @category = Category.where( :short_slug => params[:slug_3], :category_id => @category.id ).first
              if params[:slug_4]
                @category = Category.where( :short_slug => params[:slug_4], :category_id => @category.id ).first
                if params[:slug_5]
                  @category = Category.where( :short_slug => params[:slug_5], :category_id => @category.id ).first
                  if params[:slug_6]
                    @category = Category.where( :short_slug => params[:slug_6], :category_id => @category.id ).first
                  end
                end
              end
            end
          end
        end
      end
    end

    @categories = Category.where( :category_id => @category.id ).order_by( :order_value => :asc )
    @videos = @category.videos.page( params[:videos_page] ).per( 6 )
    @n_videos = @category.videos.length
    @n_pages = ( @category.videos.length.to_f / 10 ).ceil
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

