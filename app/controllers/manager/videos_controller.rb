
class Manager::VideosController < Manager::ManagerController

  def index
    @videos = Video.all
  end

  def edit
    @video = Video.find params[:id]
  end

  def update
    @video = Video.find params[:id]
    @video.update params[:video].permit( :youtube_id, :title, :descr )
    if @video.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@video.errors.inspect}"
      render :action => "edit"
    end
  end
  
  def new
    @video = Video.new
  end

  def create
    @video = Video.create params[:video].permit( :youtube_id, :title, :descr )
    if @video.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@video.errors.inspect}"
      render :action => "new"
    end
  end

end
