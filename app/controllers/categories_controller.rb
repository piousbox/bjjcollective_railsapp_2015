
class CategoriesController < ApplicationController

  def index
    @categories = {}
    categories = Category.all
    categories.each do |category|
      arr = category.name.split(' - ')
      arr.each_with_index do |item, idx|
        @categories[arr[0]] = {} unless @categories.has_key?( arr[0] )
        @categories[arr[0]][arr[1]] = {} unless @categories[arr[0]].has_key?( arr[1] )
        @categories[arr[0]][arr[1]][arr[2]] = {} unless @categories[arr[0]][arr[1]].has_key?( arr[2] )
        @categories[arr[0]][arr[1]][arr[2]][arr[3]] = {} unless @categories[arr[0]][arr[1]][arr[2]].has_key?( arr[3] )
        @categories[arr[0]][arr[1]][arr[2]][arr[3]][arr[4]] = {} unless @categories[arr[0]][arr[1]][arr[2]][arr[3]].has_key?( arr[4] )
        @categories[arr[0]][arr[1]][arr[2]][arr[3]][arr[4]][arr[5]] = { 'link' => category.url_name } unless @categories[arr[0]][arr[1]][arr[2]][arr[3]][arr[4]].has_key?( arr[5] )
      end
    end
    render :index_2
  end

  def show
    @category = Category.find_by_url_name( params[:id] )
    @videos = @category.videos.paginate( :page => params[:page], :per_page => 10 )
  end

end

