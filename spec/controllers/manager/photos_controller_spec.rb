
require 'spec_helper'

describe Manager::PhotosController do

  render_views
  
  before :each do
    setup_questsets
    setup_merit_badges
  end

  it 'create in badge' do
    post :create, :photo => {}, :file => {}, :merit_badge_id => @merit_badge.id
    @merit_badge.photos.length.should eql 1
  end

  it 'create in questset' do
    post :create, :photo => {}, :file => {}, :questset_id => @questset.id
    @questset.photos.length.should eql 1
  end
  
end
