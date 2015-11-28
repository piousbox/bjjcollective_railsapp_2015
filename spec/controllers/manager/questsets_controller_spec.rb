
require 'spec_helper'

describe Manager::QuestsetsController do

  before :each do
    ;
  end

  it '#index' do
    get :index
    response.should be_success
    response.should render_template( 'manager/questsets/index' )
    assigns( :questsets ).should_not eql nil
  end
  
end
