class Manager::MeritBadgesController < Manager::ManagerController

  before_filter :set_lists

  def index
    @badges = MeritBadge.all.order_by( :order_value => 'asc' ).to_a
    render :layout => 'manager_bootstrap'
  end

  def new
    @badge = MeritBadge.new
    # puts! @questpages_list, 'questpages_list'
  end

  def edit
    @badge = MeritBadge.find params[:id]
  end

  def create
    @badge = MeritBadge.new 
    do_update_photos
    @badge.update_attributes params[:merit_badge].permit!
    do_save
  end

  def update
    @badge = MeritBadge.find params[:id]
    do_update_photos
    @badge.update_attributes params[:merit_badge].permit!
    do_save
  end

  def show
    begin
      @badge = Badge.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound
      @badge = Badge.find_by :location_name => params[:id]
    end
  end

  #
  # private
  #
  private

  def do_update_photos
    if params[:merit_badge][:unavailable_photo]
      photo = Photo.new
      photo.photo = params[:merit_badge][:unavailable_photo]
      @badge.unavailable_photo = photo
      params[:merit_badge].delete :unavailable_photo
    end
    if params[:merit_badge][:shaded_photo]
      photo = Photo.new
      photo.photo = params[:merit_badge][:shaded_photo]
      @badge.shaded_photo = photo
      params[:merit_badge].delete :shaded_photo
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
      params[:merit_badge].delete :accomplished_photo
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
      params[:merit_badge].delete :title_photo
    end

    if params[:merit_badge][:unavailable_photo]
      photo = Photo.new
      photo.photo = params[:merit_badge][:unavailable_photo]
      photo.unavailable_badge = @badge
      if photo.save
      else
        flash[:alert] = "No Luck: #{photo.errors.messages}"
        render :action => :new and return
      end
      params[:merit_badge].delete :unavailable_photo
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
  
