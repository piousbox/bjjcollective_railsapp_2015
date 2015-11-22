
require 'spec_helper'

describe Manager::VideosController do

  before :each do
    ;
  end

  it '#index' do
    get :index
    response.should be_success
    response.should render_template( 'manager/videos/index' )
    assigns( :videos ).should_not eql nil
  end
  
end
