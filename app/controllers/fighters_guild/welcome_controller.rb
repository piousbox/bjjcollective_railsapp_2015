
class FightersGuild::WelcomeController < FightersGuild::FightersGuildController

  def home
    @badges = MeritBadge.all
    @questsets = Questset.all
  end

end


