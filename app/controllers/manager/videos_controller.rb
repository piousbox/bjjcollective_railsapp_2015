
class Manager::VideosController < Manager::ManagerController

  before_filter :set_lists
  
  def index
    @videos = Video.all
    if params[:badge_id]
      @videos = @videos.where( :merit_badge_id => params[:badge_id] )
    end
    if params[:questset_id]
      @videos = @videos.where( :questset_id => params[:questset_id] )
    end
    @videos = @videos.page( params[:videos_page] ).per( 20 )
  end

  def edit
    @video = Video.find params[:id]
  end

  def update
    @video = Video.find params[:id]
    @video.update params[:video].permit( permitted_params )

    do_update_tasks
    
    if @video.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@video.errors.messages}"
      render :action => "edit"
    end
  end
  
  def new
    @video = Video.new
  end

  def create
    @video = Video.create params[:video].permit( permitted_params ) # :youtube_id, :title, :descr, :merit_badge_id, :questset_id, :badge_id )

    do_update_tasks
    
    if @video.save
      flash[:notice] = 'Success.'
      redirect_to :action => 'index'
    else
      flash[:alert] = "No Luck. #{@video.errors.messages}"
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
  
  def permitted_params
    return [ :youtube_id, :title, :descr, :merit_badge_id, :questset_id, :badge_id, :category_id, :order_value ]
  end
  
end
