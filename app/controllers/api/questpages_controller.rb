class Api::QuestpagesController < Api::ApiController
  before_action :set_profile, :except => [ :index, :show ]

  def index
    @questpages = Questpage.where( :is_trash => false )
    authorize! :index, Questpage
  end

  def show
    @questpage = Questpage.find_by :slug => params[:slug]
    authorize! :show, Questpage
  end

end
