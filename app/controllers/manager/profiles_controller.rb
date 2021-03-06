
class Manager::ProfilesController < Manager::ManagerController

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find params[:id]
  end

  def update
    @profile = Profile.find params[:id]
    flag = @profile.update_attributes params[:profile].permit!
    if flag
      flash[:notice] = 'Updated profile.'
    else
      flash[:alert] = "Cannot update profile: #{@profile.errors.messages}"
    end
    redirect_to :action => 'index'
  end

  def destroy 
    @profile = Profile.find params[:id]
    if @profile.destroy
      flash[:notice] = "Destroyed profile #{params[:id]}"
    else
      flash[:alert] = "Cannot destroy profile: #{@profile.errors.messages}"
    end
    redirect_to :action => 'index'
  end

end
