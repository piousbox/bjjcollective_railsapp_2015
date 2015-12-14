
class FightersGuild::PlayerVideosController < FightersGuild::FightersGuildController

  def update
    @player_video = PlayerVideo.find params[:id]
    authorize! :update, @player_video

    puts! params
    
    if "true" === params[:task_1_ok]
      @player_video.task_1_ok = true
    end
    if "true" === params[:task_2_ok]
      @player_video.task_2_ok = true
    end
    if "true" === params[:task_3_ok]
      @player_video.task_3_ok = true
    end
    if "false" === params[:task_1_ok]
      @player_video.task_1_ok = false
    end
    if "false" === params[:task_2_ok]
      @player_video.task_2_ok = false
    end
    if "false" === params[:task_3_ok]
      @player_video.task_3_ok = false
    end

    flag = @player_video.save
    if flag
      render :json => { :status => :ok }
    else
      render :json => { :status => :not_ok }
    end
    
  end

end
