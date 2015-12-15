
class FightersGuild::WelcomeController < FightersGuild::FightersGuildController

  def home
    authorize! :home, Ability
    
    @badges = MeritBadge.all.order_by( :order_value => 'asc' ).to_a
    if user_signed_in?
      @badges.each_with_index do |badge, idx|
        # have I accomplished this badge?
        @badges[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = Video.where( :merit_badge_id => badge.id )
        churn_badge :badge => @badges[idx], :videos => videos
      end
    end

    @questsets = Questset.all.order_by( :order_value => 'asc' ).to_a
    if user_signed_in?
      @questsets.each_with_index do |q, idx|
        # have I accomplished thiswquestset?
        @questsets[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = Video.where( :questset_id => q.id )
        churn_badge :badge => @questsets[idx], :videos => videos
      end
    end
    # have I accomplished thiswquestset?
    churn_questsets
    
  end

  def about
    authorize! :about, Ability
  end

  private

  def churn_badge args={}
    badge  = args[:badge]
    @a = badge
    
    videos = args[:videos]
    videos.each do |video|
      player_video = PlayerVideo.where( :user_id => current_user.id, :video_id => video.id ).first
      if player_video
        video.tasks.each do |task|
          if player_video.tasks.include? task.id.to_s
            badge[:player][:n_done] += 1
          else
            badge[:player][:n_not_done] += 1
            badge[:player][:is_accomplished] = false
          end
        end
        badge[:player][:percent_done] = 100 * badge[:player][:n_done].to_f / ( 0.0001 + badge[:player][:n_done] + badge[:player][:n_not_done] )
      else
        badge[:player][:percent_done] = 0
      end
    end
    if 0 == videos.length
      badge[:player][:percent_done] = 0
      badge[:player][:is_accomplished] = false
    end
  end

  def churn_questsets
    qs = @questsets
    
    @questsets.each_with_index do |q, idx|
      if 0 == idx
        q[:is_available] = true
      elsif user_signed_in?
        if qs[idx-1][:player][:is_accomplished]
          q[:is_available] = true
        else
          q[:is_available] = false
        end
      else
        q[:is_available] = false
      end
    end
  end
  
end

