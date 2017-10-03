
class Manager::TasksController < Manager::ManagerController

  def new
    @task = Task.new
    @task.badge_id = params[:badge_id] if params[:badge_id]
  end

  def create
    task = Task.new params[:task].permit( :title, :mouseover )

    if params[:video_id]
      video = Video.find params[:video_id]
      video.tasks << task
      if video.save
        render :json => { :status => :ok, :id => task.id.to_s }
      else
        puts! video.errors, "Cannot save video when manager creates a task."
        render :json => { :status => :not_ok, :errors => video.errors.to_json }
      end
      return
    end

    if params[:badge_id]
      task[:badge_id] = params[:badge_id]
      if task.save
        redirect_to manager_badge_path( params[:badge_id] ), :notice => 'success'
      else
        flash[:alert] = 'Cannot save task: ', task.errors.messages
        render :action => :new
      end
      return
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

end

