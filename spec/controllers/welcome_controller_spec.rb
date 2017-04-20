require 'spec_helper'

describe WelcomeController do
  render_views
  before :each do
    ;
  end

  it '#home' do
    get :home
    response.should be_redirect
  end

  it '#donate' do
    get :donate
    response.should be_success
  end
 
end
