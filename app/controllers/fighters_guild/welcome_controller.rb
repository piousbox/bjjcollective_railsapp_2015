
class FightersGuild::WelcomeController < FightersGuild::FightersGuildController

  def home
    @badges = MeritBadge.all
  end

end


