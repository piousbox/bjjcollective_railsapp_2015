
class Api::QuestpagesController < Api::ApiController

  def index
    @questpages = Questpage.all
    authorize! :index, Questpage
  end

  def show
    @questpage = Questpage.find_by :slug => params[:slug]
    authorize! :show, Questpage
  end

end
