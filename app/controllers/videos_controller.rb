
class VideosController < ApplicationController

  def show
    @categories = Category.where( :category => nil )
    @video = Video.find( params[:id] )
    c = @video.category
    create_categories_list c
  end

end

