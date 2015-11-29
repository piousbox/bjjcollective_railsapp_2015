
require 'spec_helper'

describe WelcomeController do

  before :each do
    ;
  end

  it '#home' do
    get :home
    response.should be_redirect
    response.should redirect_to( '/fighters_guild' )
  end
  
end
