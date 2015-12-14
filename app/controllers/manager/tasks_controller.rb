
class Manager::TasksController < Manager::ManagerController

  def create
    task = Task.new params[:task].permit( :title, :mouseover )
    # video = Video.find params[:task][:video_id]
    video = Video.find params[:video_id]
    video.tasks << task
    flag = video.save
    if flag
      render :json => { :status => :ok }
    else
      puts! video.errors, "Cannot save video when manager creates a task."
      render :json => { :status => :not_ok, :errors => video.errors.to_json }
    end
  end

end

