
class Manager::QuestsetsController < Manager::ManagerController

  def index
    @questsets = Questset.all
  end

end
