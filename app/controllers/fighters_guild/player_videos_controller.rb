
class FightersGuild::PlayerVideosController < FightersGuild::FightersGuildController

  def update
    @player_video = PlayerVideo.find params[:id]
    authorize! :update, @player_video

    if 'Complete' == params[:commit]
      @player_video.tasks << params[:task_id] unless @player_video.tasks.include?( params[:task_id] )
    elsif 'Undo' == params[:commit]
      @player_video.tasks.delete params[:task_id]
    else
      message = "Unknown commit! Should be either Complete or Undo."
      puts! message
      render :json => { :status => :not_ok, :message => message }
      return
    end
    
    flag = @player_video.save
    if flag
      render :json => { :status => :ok, :task_id => params[:task_id].to_s }
    else
      render :json => { :status => :not_ok }
    end
    
  end

end
