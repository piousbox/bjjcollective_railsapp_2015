# require 'stripe'

class Api::StarsController < Api::ApiController

  def buy
    authorize! :buy_stars, Ability

    ::Stripe.api_key = "sk_test_ARuaXffdANoXLKAwUXDcp0v0"
    acct = Stripe::Account.create(
      :country => "US",
      :type => "custom"
    )
    
    charge = Stripe::Charge.create(
      :amount => params['amount'],
      :currency => "usd",
      :source => params['token']['id'],
      :destination => {
        :account => acct,
      }
    )

    profile = Profile.find_by :fb_access_token => params['profile']['fb_access_token']
    profile.n_stars += 1
    profile.save

    render :json => { :status => :ok, :profile => profile }
  end

end
