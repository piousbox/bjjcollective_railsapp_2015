
require 'spec_helper'

describe Manager::PhotosController do

  render_views
  
  before :each do
    setup_questsets
    setup_merit_badges
    @merit_badge.id.should_not eql nil
    @questset.id.should_not eql nil
  end

  it 'create in badge' do
    post :create, :photo => {}, :merit_badge_id => @merit_badge.id
    @merit_badge = MeritBadge.find @merit_badge.id
    @merit_badge.photos.length.should eql 1
  end
  
  it 'create in questset' do
    post :create, :photo => {}, :questset_id => @questset.id
    @questset = Questset.find @questset.id
    @questset.photos.length.should eql 1
  end
  
end
