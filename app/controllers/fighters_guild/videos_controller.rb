
class FightersGuild::VideosController < FightersGuild::FightersGuildController

  def show
    authorize! :show, Video

    @video = Video.find params[:id]    
    if @video.badge_id
      @badge = MeritBadge.find @video.badge_id
      @videos = Video.where( :merit_badge_id => @badge.id )
      @videos = @videos.to_a
    end
        
    if user_signed_in?
      @videos.each do |v|
        v[:player_video] = v.player_videos.where( :user_id => current_user.id ).first || PlayerVideo.create( :user_id => current_user.id, :video_id => v.id )
      end
      @player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => @video.id ).first
      if @player_video
        @tasks_hash = {}
        @player_video.tasks.each do |task|
          @tasks_hash[task] = true
        end
      else
        @player_video = PlayerVideo.create( :video_id => @video.id, :user_id => current_user.id )
      end
    end
  end
  
end


