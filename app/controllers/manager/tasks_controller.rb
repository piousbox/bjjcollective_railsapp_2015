
class Manager::TasksController < Manager::ManagerController

  before_action :set_lists

  def new
    @task = Task.new
    @task.badge_id = params[:badge_id] if params[:badge_id]
  end

  def create
    @task = Task.new params[:task].permit!
    authorize! :create, @task

    params[:task].delete( :video_id ) if params[:task][:video_id].blank?
    params[:task].delete( :badge_id ) if params[:task][:badge_id].blank?
    
    if params[:task][:video_id] && params[:task][:badge_id]
      flash[:alert] = "Let's select only either a video or a badge."
      render :action => :new
      return
    end

    if @task.save
      flash[:notice] = "Saved the task."
      redirect_to :action => :index
    else
      flash[:alert] = "Cannot save task: #{@task.errors.messages}"
      render :action => :new
    end
  end

  def update
    video = Video.find params[:video_id]
    task = video.tasks.find params[:id]
    task.update_attributes params[:task].permit( :title, :mouseover )
    flag = video.save
    if flag
      render :json => { :status => :ok, :id => task.id.to_s }
    else
      puts! video.errors, "Cannot update task in a video."
      render :json => { :status => :not_ok }
    end
  end

  def index
    @tasks = Task.all
    authorize! :index, Task
  end

  #
  # private
  #
  private

  def set_lists
    @videos_list = Video.list
    @badges_list = Badge.list
  end

end

