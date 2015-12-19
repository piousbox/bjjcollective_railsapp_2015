
class VideosController < ApplicationController

  def show
    @video = Video.find( params[:id] )
    c = @video.category
    create_categories_list c
  end

end

