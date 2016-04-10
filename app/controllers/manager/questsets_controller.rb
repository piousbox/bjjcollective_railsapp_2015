
class Manager::QuestsetsController < Manager::ManagerController

  before_filter :set_lists

  def index
    @questsets = Questset.all.order_by( :order_value => 'asc' )
  end

  def new
    @questset = Questset.new
  end

  def create
    @questset = Questset.new params[:questset].permit( permit_params )
    do_update_photos
    do_save
  end

  def edit
    @questset = Questset.find params[:id]
  end

  def update
    @questset = Questset.find params[:id]
    @questset.update_attributes params[:questset].permit( permit_params )
    do_update_photos
    do_save
  end
  
  private

  def do_update_photos
    if params[:questset][:unavailable_photo]
      photo = Photo.new
      photo.photo = params[:questset][:unavailable_photo]
      photo.unavailable_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:questset][:shaded_photo]
      photo = Photo.new
      photo.photo = params[:questset][:shaded_photo]
      photo.shaded_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:questset][:accomplished_photo]
      photo = Photo.new
      photo.photo = params[:questset][:accomplished_photo]
      photo.accomplished_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:questset][:title_photo]
      photo = Photo.new
      photo.photo = params[:questset][:title_photo]
      photo.title_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end
  end

  def do_save
    if @questset.save
      flash[:notice] = 'Success.'
      redirect_to manager_questsets_path
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@questset.errors.messages}"
      render :action => :new
    end
  end

  def permit_params
    [ :title, :subhead, :descr,
      :unavailable_mouseover, :shaded_mouseover, :accomplished_mouseover,
      :order_value ]
  end

  
end
