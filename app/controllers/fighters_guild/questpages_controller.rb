
class FightersGuild::QuestpagesController < FightersGuild::FightersGuildController

  def index
    authorize! :home, Ability
  end
  
  def show
    authorize! :home, Ability

    @questpage = Questpage.find params[:id]
    @badges = @questpage.merit_badges.to_a
    
    if user_signed_in?
      @badges.each_with_index do |badge, idx|
        # have I accomplished this badge?
        @badges[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = @badges[idx].videos # Video.where( :merit_badge_id => badge.id )
        churn_badge :badge => @badges[idx], :videos => videos, :user => current_user
      end
      @badges.sort_by! { |i| i[:order_value] }
    end
    
    @questsets = Questset.all.where( :questpage_id => @questpage.id ).order_by( :order_value => :asc ).to_a
    if user_signed_in?
      @questsets.each_with_index do |q, idx|
        # have I accomplished this questset?
        @questsets[idx][:player] = { :is_accomplished => true, :n_done => 0, :n_not_done => 0 }
        videos = Video.where( :questset_id => q.id )
        churn_badge :badge => @questsets[idx], :videos => videos, :user => current_user
      end
    end
    # have I accomplished this questset?
    churn_questsets @questsets

    # @TODO: definitely abstract this _vp_ 20160523
    @questsets.each_with_index do |q, idx|
      @questsets[idx][:order_value] = @questsets[idx][:unaccomplished_order_value]
    end

  end

end
