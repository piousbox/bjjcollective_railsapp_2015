
require 'spec_helper'

describe WelcomeController do

  before :each do
    ;
  end

  describe "#home" do
    it 'renders' do
      get :home
      response.should be_redirect
      response.should redirect_to( '/fighters_guild' )
    end
  end
  
end
