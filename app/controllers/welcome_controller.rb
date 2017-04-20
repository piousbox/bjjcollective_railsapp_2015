include PayPal::SDK::REST

class WelcomeController < ApplicationController

  def home
    authorize! :home, Ability
    redirect_to :controller => "fighters_guild/questpages", :action => "index"
  end

  def donate
    authorize! :donate, Ability
    PayPal::SDK::Core::Config.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
    PayPal::SDK::REST.set_config(
      :mode => 'sandbox',
      :client_id => 'AYGZKBquUOZ8exH6Hev7r831dLcLGaF-M8jLdMgHkyb6hhsuEtLa9kwX5DZv2FgQboYa7W2Bzw4lG54b',
      :client_secret => 'EFD2-w4ZXwPpiR-13acTXFdbuqoi0qMT3Hl9NVzwAFIchFLK_esnglflPB3SrhPYu_vYs8l30HiL9mvW'
    )
    payment = Payment.new(
      :intent => 'sale',
      :payer => {
        :payment_method => 'paypal'
      },
      :transactions => [{
                          :amount => {
                            :total => '5.00',
                            :currency => 'USD',
                          },
                          :description => 'descr 1',
                          :custom => 'custom-field-314',
                          :invoice_number => 'i-555',
                        }],
      :redirect_urls => {
        :return_url => 'http://localhost:3000',
        :cancel_url => 'http://localhost:3000'
      }
    )
    if payment.create
      puts! payment.id
      puts! payment.links[1].href
      redirect_to payment.links[1].href
    else
      puts! payment.error
    end
  end

end
