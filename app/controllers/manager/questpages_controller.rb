class Manager::QuestpagesController < Manager::ManagerController

  before_filter :set_lists

  def index
    @questpages = Questpage.all
  end

  def new
    @questpage = Questpage.new
  end

  def create
    @questpage = Questpage.new params[:questpage].permit( permit_params )
    do_update_photos
    do_save
  end

  def edit
    @questpage = Questpage.find params[:id]
  end

  def update
    @questpage = Questpage.find params[:id]
    @questpage.update_attributes params[:questpage].permit( permit_params )
    do_update_photos
    do_save
  end
  
  private

  def do_update_photos
    if params[:questpage][:unavailable_photo]
      photo = Photo.new
      photo.photo = params[:questpage][:unavailable_photo]
      photo.unavailable_badge = @questpage
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:questpage][:shaded_photo]
      photo = Photo.new
      photo.photo = params[:questpage][:shaded_photo]
      photo.shaded_badge = @questpage
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:questpage][:accomplished_photo]
      photo = Photo.new
      photo.photo = params[:questpage][:accomplished_photo]
      photo.accomplished_badge = @questpage
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:questpage][:title_photo]
      photo = Photo.new
      photo.photo = params[:questpage][:title_photo]
      photo.title_badge = @questpage
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end
  end

  def do_save
    if @questpage.save
      flash[:notice] = 'Success.'
      redirect_to manager_questpages_path
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@questpage.errors.messages}"
      render :action => :new
    end
  end

  def permit_params
    [ :title, :subhead, :descr,
      :unavailable_mouseover, :shaded_mouseover, :accomplished_mouseover,
      :order_value ]
  end
end

