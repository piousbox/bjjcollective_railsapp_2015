
class FightersGuild::PlayerVideosController < FightersGuild::FightersGuildController

  def update
    @player_video = PlayerVideo.find params[:id]
    
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

    if @player_video.save
      render :json => { :status => :ok }
    else
      ;
    end
    
  end

end
