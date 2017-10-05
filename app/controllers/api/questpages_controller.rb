
class Api::QuestpagesController < Api::ApiController

  def index
    @questpages = Questpage.all
  end

end
