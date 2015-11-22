
class FightersGuild::VideosController < FightersGuild::FightersGuildController

  def show
    @video = Video.find params[:id]
  end

end


