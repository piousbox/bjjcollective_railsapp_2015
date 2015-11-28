
class FightersGuild::VideosController < FightersGuild::FightersGuildController

  def show
    @video = Video.find params[:id]
    @badge = @video.merit_badge
    @videos = Video.where( :merit_badge_id => @badge.id )
    if current_user
      @player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => @video.id ).first
      @player_video ||= PlayerVideo.create( :video_id => @video.id, :user_id => current_user.id )
    end
  end
  
end


