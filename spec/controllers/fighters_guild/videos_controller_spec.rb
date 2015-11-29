
require 'spec_helper'

describe FightersGuild::VideosController do

  render_views
  
  before :each do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    
    sign_in :user, @user

    MeritBadge.all.each { |b| b.remove }
    @badge = FactoryGirl.create :badge

    Questset.all.each { |q| q.remove }
    @questset = FactoryGirl.create :questset
    
    Video.all.each { |v| v.remove }
    @video_for_badge = Video.create( :title => 'Video for badge', :merit_badge => @badge )
    @video_for_questset = Video.create( :title => 'Video for questset', :questset => @questset )
  end

  it 'show in badge' do
    get :show, :id => @video_for_badge.id
    response.should be_success
    response.should render_template( 'fighters_guild/videos/show' )
    assigns( :video ).should_not eql nil
    assigns( :badge ).should_not eql nil
  end

  it 'show in questset' do
    get :show, :id => @video_for_questset.id
    response.should be_success
    response.should render_template( 'fighters_guild/videos/show' )
    assigns( :video ).should_not eql nil
    assigns( :questset ).should_not eql nil
  end
  
end
