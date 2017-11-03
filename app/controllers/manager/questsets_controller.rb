
class Manager::QuestsetsController < Manager::ManagerController

  before_filter :set_lists

  def show
    redirect_to :action => :edit
  end

  def index
    @questsets = Questset.all.order_by( :order_value => 'asc' )
  end

  def new
    @questset = Questset.new
  end

  def create
    @item = params[:questset] || params[:badge]
    @questset = Questset.new @item.permit!
    do_update_photos
    do_save
  end

  def edit
    @questset = Questset.find params[:id]
  end

  def update
    @item = params[:questset] || params[:badge]
    @item[:badge_ids].delete ''
    # byebug
    @questset = Questset.find params[:id]
    @questset.update_attributes @item.permit!
    do_update_photos
    do_save
  end
  
  private

  def do_save
    if @questset.save
      flash[:notice] = 'Success.'
      redirect_to manager_questsets_path
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@questset.errors.messages}"
      render :action => :new
    end
  end
  
end
