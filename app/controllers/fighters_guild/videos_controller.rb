
class FightersGuild::VideosController < FightersGuild::FightersGuildController

  def show
    @video = Video.find params[:id]    
    if @video.merit_badge_id
      @badge = MeritBadge.find @video.merit_badge_id
    elsif @video.questset_id
      @questset = Questset.find @video.questset_id
    end
    if @badge
      @videos = Video.where( :merit_badge_id => @badge.id )
    elsif @questset
      @videos = Video.where( :questset_id => @questset.id )
    end
    @videos = @videos.to_a
    if user_signed_in?
      @videos.each do |v|
        v[:player_video] = v.player_videos.where( :user_id => current_user.id ).first || PlayerVideo.create( :user_id => current_user.id, :video_id => v.id )
      end
      @player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => @video.id ).first
      @player_video ||= PlayerVideo.create( :video_id => @video.id, :user_id => current_user.id )
    end
  end
  
end


