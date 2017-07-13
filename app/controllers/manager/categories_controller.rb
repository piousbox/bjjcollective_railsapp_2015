
class Manager::CategoriesController < Manager::ManagerController

  before_filter :set_lists
  
  def index
    @categories = Category.all
    if params[:q]
      @categories = @categories.where( :title => /.*#{params[:q]}.*/i )
    end
    @categories = @categories.page( params[:categories_page] ).per( 20 * 4 ) # b/c it's a large-block-grid-4
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create params[:category].permit!
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
    redirect_to :action => 'edit', :id => @category.id
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    if params[:category][:photo]
      photo = Photo.new params[:category][:photo].permit!
    end

    params[:category].delete :photo
    @category = Category.find params[:id]
    @category.photo = photo if photo
    @category.update params[:category].permit!
    
    if @category.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@category.errors.messages}"
      render :action => 'edit'
    end
  end

  private

end

