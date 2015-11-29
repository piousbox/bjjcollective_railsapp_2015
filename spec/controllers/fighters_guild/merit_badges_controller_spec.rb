
require 'spec_helper'

describe FightersGuild::MeritBadgesController do

  render_views
  
  before :each do
    setup_users
    
    MeritBadge.all.each { |m| m.remove }
    @badge = FactoryGirl.create :merit_badge

    Video.all.each { |v| v.remove }
    @video = Video.create :merit_badge_id => @badge.id, :title => 'some video title'
  end

  it 'show - signed in' do
    sign_in :user, @user
    
    get :show, :id => MeritBadge.all.first.id
    response.should be_success
    response.should render_template( 'fighters_guild/merit_badges/show' )
    assigns( :badge ).should_not eql nil
    videos = assigns( :videos )
    videos.should_not eql nil
  end


  it 'show - not signed in' do
    sign_out :user

    get :show, :id => @badge.id
    response.should be_success
    assigns( :badge ).should_not eql nil
  end
  
end
