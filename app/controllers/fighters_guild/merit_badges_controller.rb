
class FightersGuild::MeritBadgesController < FightersGuild::FightersGuildController

  def show
    @badge = MeritBadge.find params[:id]
    @videos = Video.where( :merit_badge_id => @badge.id )
  end

end


