
class VideosController < ApplicationController

  def show
    @video = Video.find( params[:id] )
    c = @video.category
    @categories_list = [ c ]
    while c.category
      @categories_list.unshift c.category
      c = c.category
    end
  end

end

