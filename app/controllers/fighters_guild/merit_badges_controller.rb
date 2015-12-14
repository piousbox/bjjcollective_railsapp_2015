
class FightersGuild::MeritBadgesController < FightersGuild::FightersGuildController

  def show
    authorize! :show, MeritBadge
    
    @badge = MeritBadge.find params[:id]
    @videos = Video.where( :merit_badge_id => @badge.id ).order_by( :order_value => 'desc' ).to_a

    if user_signed_in?
      @videos.each do |video|
        video[:player_video] = video.player_videos.where( :user_id => current_user.id ).first || PlayerVideo.create( :user_id => current_user.id, :video_id => video.id )
      end
    else
      @videos.each do |video|
        video[:player_video] = PlayerVideo.new
      end
    end
  end

end


