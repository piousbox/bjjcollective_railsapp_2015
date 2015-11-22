
class Manager::VideosController < Manager::ManagerController

  def index
    @videos = Video2.all
  end

  def edit
  end

  def update
  end
  
  def new
  end

  def create
  end

end
