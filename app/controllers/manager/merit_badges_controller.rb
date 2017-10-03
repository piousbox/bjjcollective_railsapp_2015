class Manager::MeritBadgesController < Manager::ManagerController

  before_filter :set_lists

  PERMITTED_PARAMS = [:title, :subhead, :descr, :shaded_mouseover, :accomplished_mouseover, :order_value, :questpage, :questpage_id]
  
  def index
    @badges = MeritBadge.all.order_by( :order_value => 'asc' ).to_a
  end

  def new
    @badge = MeritBadge.new
    # puts! @questpages_list, 'questpages_list'
  end

  def edit
    @badge = MeritBadge.find params[:id]
  end

  def create
    @badge = MeritBadge.new params[:merit_badge].permit( PERMITTED_PARAMS )
    do_update_photos
    do_save
  end

  def update
    @badge = MeritBadge.find params[:id]
    @badge.update_attributes( params[:merit_badge].permit( PERMITTED_PARAMS ) )
    do_update_photos
    do_save
  end

  private

  def do_update_photos
    if params[:merit_badge][:shaded_photo]
      photo = Photo.new
      photo.photo = params[:merit_badge][:shaded_photo]
      @badge.shaded_photo = photo
      if @badge.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:merit_badge][:accomplished_photo]
      photo = Photo.new
      photo.photo = params[:merit_badge][:accomplished_photo]
      photo.accomplished_badge = @badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end

    if params[:merit_badge][:title_photo]
      photo = Photo.new
      photo.photo = params[:merit_badge][:title_photo]
      photo.title_badge = @badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
    end
  end

  def do_save
    if @badge.save
      flash[:notice] = 'Success.'
      redirect_to manager_badges_path
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@badge.errors.messages}"
      render :action => :new
    end
  end

end

