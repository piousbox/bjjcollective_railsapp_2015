
require 'spec_helper'

describe Manager::VideosController do

  before :each do
    MeritBadge.all.each { |b| b.remove }
    @badge = FactoryGirl.create :badge
  end

  it '#index' do
    get :index
    response.should be_success
    response.should render_template( 'manager/videos/index' )
    assigns( :videos ).should_not eql nil
  end

  it '#index in badge' do
    get :index, :badge_id => @badge.id
    assigns( :videos ).each do |v|
      v.merit_badge_id.should eql @badge.id
    end
  end

  it '#new' do
    get :new
    response.should be_success
    response.should render_template( 'manager/videos/new' )
    assigns( :video ).should_not eql nil
  end
  
end
