include PayPal::SDK::REST

class Donation
  include Mongoid::Document
  include Mongoid::Timestamps
  include ::Utils

  field :invoice_number, :type => String
  field :amount,         :type => Float

  field :payer_id,   :type => String
  field :token,      :type => String
  field :payment_id, :type => String

  def redirect_to
    # PayPal::SDK::Core::Config.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
    PayPal::SDK::REST.set_config(
      :mode          => ::PAYPAL_CONFIG[:mode],
      :client_id     => ::PAYPAL_CONFIG[:client_id],
      :client_secret => ::PAYPAL_CONFIG[:client_secret]
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
                          :invoice_number => Donation.next_invoice_number,
                        }],
      :redirect_urls => {
        :return_url => 'http://localhost:3000',
        :cancel_url => 'http://localhost:3000'
      }
    )
    if payment.create
      # puts! payment.id
      # puts! payment.links[1].href
      redirect_to payment.links[1].href
    else
      puts! payment.error, 'payment error'
    end
  end

  INVOICE_PREFIX = "invoice-"
  def self.next_invoice_number
    "#{Donation::INVOICE_PREFIX}#{Donation.count}"
  end

end
