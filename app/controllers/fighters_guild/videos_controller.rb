
class FightersGuild::VideosController < FightersGuild::FightersGuildController

  def show
    @video = Video.find params[:id]
    
    puts! @video.inspect, 'video is'
    MeritBadge.all.each do |b|
      puts! b.inspect, 'some badge'
    end
    Questset.all.each do |q|
      puts! q.inspect, 'some questset'
    end
    
    if @video.merit_badge_id
      @badge = MeritBadge.find @video.merit_badge_id
    elsif @video.questset_id
      @questset = Questset.find @video.questset_id
    end
    puts! @badge, 'badge is'
    if @badge
      @videos = Video.where( :merit_badge_id => @badge.id )
    elsif @questset
      @videos = Video.where( :questset_id => @questset.id )
    end
    if current_user
      @player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => @video.id ).first
      @player_video ||= PlayerVideo.create( :video_id => @video.id, :user_id => current_user.id )
    end
  end
  
end


