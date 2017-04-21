require 'spec_helper'

describe Donation do
  before :each do
    Donation.clear
  end
  
=begin
  ## obsolete 20170420
  it '#next_invoice_number' do
    d_number = Donation.next_invoice_number
    d = Donation.create
    d.persisted?.should eql true
    d2_number = Donation.next_invoice_number
    d2 = Donation.create
    d2.persisted?.should eql true
    d2_number.should_not eql d_number
  end
=end

  it '#redirect_to' do
    rr = Donation.new.redirect_to
    rr.start_with?("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=").should eql true
    rr.length.should eql( "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-3AD61500WF738570E".length )
  end

end
