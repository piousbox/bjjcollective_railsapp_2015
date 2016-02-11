
require 'spec_helper'

describe Manager::VideosController do

  render_views
  
  before :each do
    MeritBadge.all.each { |b| b.remove }
    @badge = FactoryGirl.create :badge

    setup_categories
    
    setup_videos
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

  it '#create' do
    ;
  end

  it '#edit' do
    ;
  end

  it '#update' do
    @video.category_id.should eql nil
    post :update, :id => @video.id, :video => { :category_id => @category.id }
    result = Video.find @video.id
    result.category.title.should eql @category.title
  end
  
end
