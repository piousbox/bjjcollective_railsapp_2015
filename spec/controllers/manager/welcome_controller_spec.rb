
require 'spec_helper'

describe Manager::WelcomeController do

  render_views
  
  before :each do
    ;
  end

  describe 'home' do
    before :each do
      get :home
    end
    
    it 'shows up' do
      response.should be_success
      response.should render_template( 'manager/welcome/home' )
    end
  end
  
end
