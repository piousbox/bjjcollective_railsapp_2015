
class Manager::VideosController < Manager::ManagerController

  before_filter :set_lists
  
  def index
    @videos = Video.all
  end

  def edit
    @video = Video.find params[:id]
  end

  def update
    @video = Video.find params[:id]
    @video.update params[:video].permit( :youtube_id, :title, :descr, :merit_badge_id )

    do_update_tasks
    
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
    @video.build_task_1
    @video.build_task_2
    @video.build_task_3
  end

  def create
    @video = Video.create params[:video].permit( :youtube_id, :title, :descr )

    do_update_tasks
    
    if @video.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@video.errors.inspect}"
      render :action => "new"
    end
  end

  private

  def do_update_tasks
    if params[:video][:task_1]
      task = Task.new params[:video][:task_1].permit( :title, :mouseover )
      @video.task_1 = task
    end
    if params[:video][:task_2]
      task = Task.new params[:video][:task_2].permit( :title, :mouseover )
      @video.task_2 = task
    end
    if params[:video][:task_3]
      task = Task.new params[:video][:task_3].permit( :title, :mouseover )
      @video.task_3 = task
    end  
  end

end
