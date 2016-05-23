
class FightersGuild::WelcomeController < FightersGuild::FightersGuildController

  def home
    authorize! :home, Ability
    
    render 'fighters_guild/questpages/index'
  end
  
  def _20160409_home_trash
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
    # have I accomplished this questset?
    churn_questsets @questsets
    
  end

  def about
    authorize! :about, Ability
  end

end

