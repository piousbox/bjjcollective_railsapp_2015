
class Api::QuestpagesController < Api::ApiController

  def index
    @questpages = Questpage.all
    authorize! :index, Questpage
  end

end
