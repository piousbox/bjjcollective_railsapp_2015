
class FightersGuild::QuestsetsController < FightersGuild::FightersGuildController

  def show
    @questset = Questset.find params[:id]
    @videos = Video.where( :questset_id => @questset.id )
  end

end
