class Api::QuestsetsController < Api::ApiController
  before_action :set_profile

  ## Let's set profile only on private show
  def show
    # puts! request.headers['version'], 'headers.version'
    # puts! request.headers['accessToken'], 'headers.accessToken'

    if params[:id]
      @questset = Questset.find params[:id]
    elsif params[:location_name]
      @questset = Questset.find_by :location_name => params[:location_name]
    end

    authorize! :show, @questset

    if params[:debug] == 'abba' && Rails.env.development?
      render 'show_tgm3'
      return
    end

    case request.headers[:version]
    when 'tgm3'
      render 'show_tgm3'
    else
      render
    end
  end

end

