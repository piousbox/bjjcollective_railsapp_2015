
class FightersGuild::QuestpagesController < FightersGuild::FightersGuildController

  def show
    authorize! :show, Questpage
    
    @questpage = Questpage.find params[:id]

    @badges = MeritBadge.all.where( :questpage_id => @questpage.id ).order_by( :order_value => 'asc' ).to_a
    if user_signed_in?
      @badges.each_with_index do |badge, idx|
        # have I accomplished this badge?
        @badges[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = Video.where( :merit_badge_id => badge.id )
        churn_badge :badge => @badges[idx], :videos => videos
      end
    end

    @questsets = Questset.all.where( :questpage_id => @questpage.id ).order_by( :order_value => 'asc' ).to_a
    if user_signed_in?
      @questsets.each_with_index do |q, idx|
        # have I accomplished this questset?
        @questsets[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = Video.where( :questset_id => q.id )
        churn_badge :badge => @questsets[idx], :videos => videos
      end
    end
    # have I accomplished this questset?
    churn_questsets @questsets
    
    render 'fighters_guild/welcome/home'
  end

end
