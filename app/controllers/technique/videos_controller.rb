
class Technique::VideosController < Technique::TechniqueController

  def legacy_show
    @video = Video.where( :legacy_id => params[:legacy_id] ).first
    redirect_to :controller => 'categories', :action => 'video', :id => @video.id, :status => 301
  end
  
end

