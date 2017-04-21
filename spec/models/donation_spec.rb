require 'spec_helper'

describe Donation do
  before :each do
    Donation.clear
  end
  
  it '#next_invoice_number' do
    d_number = Donation.next_invoice_number
    d = Donation.create
    d.persisted?.should eql true
    d2_number = Donation.next_invoice_number
    d2 = Donation.create
    d2.persisted?.should eql true
    d2_number.should_not eql d_number
  end
  
end
