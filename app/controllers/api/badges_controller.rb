
class Api::BadgesController < Api::ApiController

  before_action :set_profile, :only => [ :buy ]

  def show
    begin
      @badge = Badge.find_by :location_name => params[:badgename]
    rescue Mongoid::Errors::DocumentNotFound
      @badge = Badge.find params[:badgename]
    end
    authorize! :show, @badge
  end

  def buy
    puts! request.headers['accessToken'], 'headers.accessToken'
    puts! request.headers['version'], 'headers.version'

    @badge = MeritBadge.find_by :location_name => params[:location_name]
    authorize! :buy, @badge

    puts! @current_profile, 'current_profile'
    
    ::Stripe.api_key = STRIPE[:secret]
    created_account = Stripe::Account.retrieve(@badge.created_profile.stripe_account_id)
    amount = @badge.cost * 100 
    destination_amount = ( amount * (1-@badge.created_profile.commission) ).to_i
    charge = Stripe::Charge.create(
      :amount => amount.to_i,
      :currency => "usd",
      :source => params['token']['id'],
      :destination => {
        :account => created_account,
        :amount => destination_amount
      }
    )

    @current_profile.bought_badges << @badge
    if @current_profile.save
      render :json => { :status => :ok }
    else
      render :json => { :status => :not_ok, :error => @current_profile.errors.messages }
    end
  end

end
