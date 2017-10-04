
class Api::QuestsetsController < Api::ApiController

  def show
    if params[:id]
      @questset = Questset.find params[:id]
    elsif params[:location_name]
      @questset = Questset.find_by :location_name => params[:location_name]
    end

    case request.headers[:version]
    when 'tgm3'
      render 'show_tgm3'
    else
      render
    end
  end

end

