
class FightersGuild::MeritBadgesController < FightersGuild::FightersGuildController

  def show
    @badge = MeritBadge.find params[:id]
  end

end


