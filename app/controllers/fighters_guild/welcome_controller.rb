
class FightersGuild::WelcomeController < FightersGuild::FightersGuildController

  def home
    @badges = MeritBadge.all.to_a

    if user_signed_in?
      @badges.each_with_index do |badge, idx|
        # have I accomplished this badge?
        @badges[idx][:player] = { :is_accomplished => true }
        videos = Video.where( :merit_badge_id => badge.id )
        videos.each do |video|
          player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => video.id ).first
          if player_video && player_video.task_1_ok && player_video.task_2_ok && player_video.task_3_ok
          else
            @badges[idx][:player][:is_accomplished] = false
          end
        end
      end
    end
    
    @questsets = Questset.all
  end

end


