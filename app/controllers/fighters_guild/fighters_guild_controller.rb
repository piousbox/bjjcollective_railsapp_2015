
class FightersGuild::FightersGuildController < ApplicationController
  
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end

  before_filter :set_lists
  
  protected

  def set_lists
    @questpages = Questpage.all
  end

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
        badge[:player][:is_accomplished] = false
      end
    end
    if 0 == videos.length
      badge[:player][:percent_done] = 0
      badge[:player][:is_accomplished] = false
    end
  end

  def churn_questsets qs    
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

