
class FightersGuild::WelcomeController < FightersGuild::FightersGuildController

  def home
    @badges = MeritBadge.all.order_by( :order_value => 'asc' ).to_a

    if user_signed_in?
      @badges.each_with_index do |badge, idx|
        # have I accomplished this badge?
        @badges[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = Video.where( :merit_badge_id => badge.id )
        videos.each do |video|
          player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => video.id ).first
          if player_video
            if player_video.task_1_ok
              @badges[idx][:player][:n_done] += 1
            else
              @badges[idx][:player][:n_not_done] += 1
              @badges[idx][:player][:is_accomplished] = false
            end
            if player_video.task_2_ok
              @badges[idx][:player][:n_done] += 1
            else
              @badges[idx][:player][:n_not_done] += 1
              @badges[idx][:player][:is_accomplished] = false
            end
            if player_video.task_3_ok
              @badges[idx][:player][:n_done] += 1
            else
              @badges[idx][:player][:n_not_done] += 1
              @badges[idx][:player][:is_accomplished] = false
            end
            @badges[idx][:player][:percent_done] = 100 * @badges[idx][:player][:n_done].to_f / ( 0.0001 + @badges[idx][:player][:n_done] + @badges[idx][:player][:n_not_done] )
          else
            @badges[idx][:player][:percent_done] = 0
          end
        end
        if 0 == videos.length
          @badges[idx][:player][:percent_done] = 0
        end
      end
    end
    
    @questsets = Questset.all.order_by( :order_value => 'asc' )
  end

  def about
  end
  
end


