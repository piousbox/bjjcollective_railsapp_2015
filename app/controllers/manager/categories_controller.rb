
class Manager::CategoriesController < Manager::ManagerController

  before_filter :set_lists
  
  def index
    @categories = Category.all.page( params[:categories_page] ).per( 20 * 4 ) # b/c it's a large-block-grid-4
    if params[:q]
      @categories = @categories.where( :title => /.*#{params[:q]}.*/i )
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create params[:category].permit permitted_params
    if @category.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@category.errors.messages}"
      render :action => 'new'
    end
  end

  def show
    @category = Category.find params[:id]
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    @category.update params[:category].permit permitted_params
    
    if params[:category][:photo]
      photo = Photo.new
      photo.photo = params[:category][:photo]
      @category.photo = photo
    end
    
    if @category.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@category.errors.messages}"
      render :action => 'edit'
    end
  end

  private

  def permitted_params
    return [ :title, :slug, :short_slug, :path, :kind,
             :subhead, :descr, :is_simple, :order_value, :category, :category_id ]
  end
  

end

