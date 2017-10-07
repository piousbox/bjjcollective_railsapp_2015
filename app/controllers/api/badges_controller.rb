
class Api::BadgesController < Api::ApiController

  def show
    begin
      @badge = Badge.find_by :location_name => params[:badgename]
    rescue Mongoid::Errors::DocumentNotFound
      @badge = Badge.find params[:badgename]
    end
    authorize! :show, @badge
  end

end
