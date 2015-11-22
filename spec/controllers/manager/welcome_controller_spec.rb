
require 'spec_helper'

describe Manager::WelcomeController do

  before :each do
    ;
  end

  it '#home' do
    get :home
    response.should be_success
    response.should render_template( 'manager/welcome/home' )
  end
  
end
