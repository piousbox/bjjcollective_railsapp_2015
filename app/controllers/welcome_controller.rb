class WelcomeController < ApplicationController

  def home
    authorize! :home, Ability
    if params[:paymentId] && params[:token] && params[:PayerID]
      # byebug
      payment = Payment.find( params[:paymentId] )
      flag = payment.execute( :payer_id => params[:PayerID] )
      puts! flag, 'flag'
    end
    redirect_to :controller => "fighters_guild/questpages", :action => "index"
  end

  def donate
    authorize! :donate, Ability
    donation = Donation.new
    redirect_to donation.redirect_to
  end

end
