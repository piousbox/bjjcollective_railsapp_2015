
class Manager::QuestsetsController < Manager::ManagerController

  def index
    @questsets = Questset.all
  end

  def new
    @questset = Questset.new
  end

  def create
    @questset = Questset.new params[:questset].permit( :title, :subhead, :descr, :shaded_mouseover, :accomplished_mouseover, :order_value )
    do_update_photos
    do_save
  end

  def edit
    @questset = Questset.find params[:id]
  end

  def update
    @questset = Questset.find params[:id]
    @questset.update_attributes params[:questset].permit( :title, :subhead, :descr, :shaded_mouseover, :accomplished_mouseover, :order_value )
    do_update_photos
    do_save
  end
  
  private

  def do_update_photos
    if params[:questset][:shaded_photo]
      photo = Photo.new
      photo.photo = params[:questset][:shaded_photo]
      photo.shaded_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.inspect}."
        render :action => :new and return
      end
    end

    if params[:questset][:accomplished_photo]
      photo = Photo.new
      photo.photo = params[:questset][:accomplished_photo]
      photo.accomplished_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.inspect}."
        render :action => :new and return
      end
    end

    if params[:questset][:title_photo]
      photo = Photo.new
      photo.photo = params[:questset][:title_photo]
      photo.title_badge = @questset
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.inspect}."
        render :action => :new and return
      end
    end
  end

  def do_save
    if @questset.save
      flash[:notice] = 'Success.'
      redirect_to manager_questsets_path
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@questset.errors.inspect}."
      render :action => :new
    end
  end

  
end
