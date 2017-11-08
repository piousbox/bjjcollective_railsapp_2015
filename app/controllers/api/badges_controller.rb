
class Api::BadgesController < Api::ApiController

  def show
    begin
      @badge = Badge.find_by :location_name => params[:badgename]
    rescue Mongoid::Errors::DocumentNotFound
      @badge = Badge.find params[:badgename]
    end
    authorize! :show, @badge
  end

  def buy
    @badge = MeritBadge.find_by :location_name => params[:location_name]
    authorize! :buy, @badge
    
    ::Stripe.api_key = "sk_test_ARuaXffdANoXLKAwUXDcp0v0"
    created_account = Stripe::Account.retrieve(@badge.created_profile.stripe_account_id)
    amount = @badge.cost * 100
    destination_amount = ( amount * (1-@badge.created_profile.commission) ).to_i
    charge = Stripe::Charge.create(
      :amount => amount,
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
