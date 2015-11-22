
class Manager::MeritBadgesController < Manager::ManagerController

  def index
    @badges = MeritBadge.all
  end

  def new
    @badge = MeritBadge.new
  end

  def create
    @badge = MeritBadge.new params[:merit_badge].permit( :title )

    # shaded_photo
    photo = Photo.new
    photo.photo = params[:merit_badge][:shaded_photo]
    photo.save
    @badge.shaded_photo = photo0
    
    if @badge.save
      flash[:notice] = 'Success. '
      redirect_to manager_badges_path
    else
      flash[:notice] = "No Luck: #{@badge.errors}. "
      render :action => :new
    end
  end

end

