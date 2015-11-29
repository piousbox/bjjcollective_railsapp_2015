
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

  #
  # hidden
  #
  proc do # nothing
  describe 'accomplished' do
    before :each do
      pv = PlayerVideo.new :video_id => @video.id, :user_id => @user.id
      pv.task_1_ok = true
      pv.task_2_ok = true
      pv.task_3_ok = true
      pv.save
    end
    it 'show - accomplished, 1 video' do
      sign_in :user, @user
    end
    describe '2 video' do
      before :each do
      end
      it 'show - accomplished, 2 video' do
      end
      it 'show - shaded, 2 video' do
      end
    end
  end
  end
  
end
