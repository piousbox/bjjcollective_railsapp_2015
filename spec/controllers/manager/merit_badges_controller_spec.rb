
require 'spec_helper'

describe Manager::MeritBadgesController do

  before :each do
    ;
  end

  it '#index' do
    get :index
    response.should be_success
    response.should render_template( 'manager/merit_badges/index' )
    assigns( :badges ).should_not eql nil
  end
  
end
