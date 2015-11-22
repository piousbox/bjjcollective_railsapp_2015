
require 'spec_helper'

describe WelcomeController do

  before :each do
    ;
  end

  it '#home' do
    get :home
    response.should be_success
    response.should render_template( 'welcome/home' )
  end
  
end
