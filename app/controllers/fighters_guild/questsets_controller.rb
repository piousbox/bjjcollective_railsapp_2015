
class FightersGuild::QuestsetsController < FightersGuild::FightersGuildController

  def show
    @questset = Questset.find params[:id]
  end

end
