
class Manager::PhotosController < Manager::ManagerController

  def create
    photo = Photo.new
    photo.photo = params[:file]

    if params[:questset_id] && ""!=params[:questset_id]
      b = Questset.find params[:questset_id]
    elsif params[:merit_badge_id] && ""!=params[:merit_badge_id]
      b = MeritBadge.find params[:merit_badge_id]
    end
    photo.badge = b
    
    if photo.save
      photo[:original_path] = photo.photo.url :original
      photo[:thumb_url] = photo.photo.url :thumb
      render :json => { :status => :ok, :photo => photo }
    else
      puts! photo.errors, 'Could not create manager photo'
      render :json => { :status => :not_ok }
    end
  end

end

