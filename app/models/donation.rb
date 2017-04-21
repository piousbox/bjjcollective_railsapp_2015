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
                          :invoice_number => self.invoice_number,
                        }],
      :redirect_urls => {
        :return_url => ::PAYPAL_CONFIG[:redirect_url],
        :cancel_url => ::PAYPAL_CONFIG[:redirect_url]
      }
    )
    if payment.create
      return payment.links[1].href
    else
      puts! payment.error, 'payment error'
      return nil
    end
  end

  INVOICE_PREFIX = "invoice-"
=begin
  ## obsolete, let's use milliseconds instead. 20170420
  def self.next_invoice_number
    "#{Donation::INVOICE_PREFIX}#{Donation.count}"
  end
=end

  def invoice_number
    if self[:invoice_number].blank?
      self[:invoice_number] = "#{Donation::INVOICE_PREFIX}#{Time.now.strftime("%Y-%m-%d %H:%M:%S.%L").gsub(' ', '_')}"
    else
      self[:invoice_number]
    end
  end

end
