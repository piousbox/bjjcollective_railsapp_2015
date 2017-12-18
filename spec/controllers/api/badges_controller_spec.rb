require 'spec_helper'
describe Api::BadgesController do
  render_views
  
  before :each do
    setup_categories
    setup_badges
  end

  it '#show' do
    get :show, :badgename => @badge.location_name
    result = JSON.parse response.body
    result['badge'].should_not eql nil
  end
  
end
