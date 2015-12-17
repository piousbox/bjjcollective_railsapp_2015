
require 'spec_helper'

describe WelcomeController do

  before :each do
    ;
  end

  describe "#home" do
    it 'renders' do
      get :home
      response.should render_template 'welcome/home'
    end
  end
  
end
