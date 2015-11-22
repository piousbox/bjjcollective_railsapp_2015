
class Manager::MeritBadgesController < Manager::ManagerController

  def index
  end

  def new
    @badge = MeritBadge.new
  end

  def create
  end

end

