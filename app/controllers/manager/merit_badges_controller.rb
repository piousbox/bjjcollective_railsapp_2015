class Manager::MeritBadgesController < Manager::ManagerController

  before_filter :set_lists

  def index
    @badges = MeritBadge.all.order_by( :order_value => 'asc' ).to_a
    render :layout => 'manager_bootstrap'
  end

  def new
    @badge = MeritBadge.new
    # puts! @questpages_list, 'questpages_list'
  end

  def edit
    @badge = MeritBadge.find params[:id]
  end

  def create
    @badge = MeritBadge.new 
    @item = params[:merit_badge] || params[:badge]
    do_update_photos
    @badge.update_attributes @item.permit!
    do_save
  end

  def update
    @item = params[:merit_badge] || params[:badge] 
    @item.permit!
    @item[:badge_ids].delete ''
    @badge = MeritBadge.find params[:id]
    do_update_photos
    @badge.update_attributes @item
    do_save
  end

  def show
    begin
      @badge = Badge.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound
      @badge = Badge.find_by :location_name => params[:id]
    end
  end

  #
  # private
  #
  private

  def do_save
    @badge[:location_name] = nil if @badge[:location_name] == ''
    if @badge.save
      flash[:notice] = 'Success.'
      redirect_to request.referrer
    else
      flash[:alert] = "#{flash[:alert]} No Luck: #{@badge.errors.messages}"
      render :action => :edit, :id => @badge.id
    end
  end

end
  
