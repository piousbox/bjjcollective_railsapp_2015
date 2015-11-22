
class Manager::MeritBadgesController < Manager::ManagerController

  def index
    @badges = MeritBadge.all
  end

  def new
    @badge = MeritBadge.new
  end

  def create
    @badge = MeritBadge.new params[:merit_badge].permit( :title, :subhead, :descr, :shaded_mouseover, :accomplished_mouseover )

    # shaded_photo
    photo = Photo.new
    photo.photo = params[:merit_badge][:shaded_photo]
    photo.shaded_badge = @badge
    if photo.save
      ;
    else
      flash[:alert] = "No Luck: #{photo.errors.inspect}."
      render :action => :new and return
    end

    # accomplished_photo
    photo = Photo.new
    photo.photo = params[:merit_badge][:accomplished_photo]
    photo.accomplished_badge = @badge
    if photo.save
      ;
    else
      flash[:alert] = "No Luck: #{photo.errors.inspect}."
      render :action => :new and return
    end

    # title_photo
    photo = Photo.new
    photo.photo = params[:merit_badge][:title_photo]
    photo.title_badge = @badge
    if photo.save
      ;
    else
      flash[:alert] = "No Luck: #{photo.errors.inspect}."
      render :action => :new and return
    end
    
    if @badge.save
      flash[:notice] = 'Success.'
      redirect_to manager_badges_path
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@badge.errors.inspect}."
      render :action => :new
    end
  end

end

