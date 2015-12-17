
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
    @video_for_questset.tasks << Task.new( :title => 'xxtitle' )
    @video_for_questset.save
  end

  it 'show in badge signed-in' do
    get :show, :id => @video_for_badge.id
    response.should be_success
    response.should render_template( 'fighters_guild/videos/show' )
    assigns( :video ).should_not eql nil
    assigns( :badge ).should_not eql nil
  end

  it 'show in badge not signed in' do
    sign_out :user
    get :show, :id => @video_for_badge.id
    response.should be_success
    assigns( :video ).should_not eql nil
    assigns( :video ).id.should eql @video_for_badge.id
  end

  it 'show in questset signed-in' do
    get :show, :id => @video_for_questset.id
    
    response.should be_success
    response.should render_template( 'fighters_guild/videos/show' )

    assigns( :questset ).should_not eql nil

    validate_video assigns( :video )
  end

  it 'show in quest not-siged-in' do
    sign_out :user
    get :show, :id => @video_for_questset.id
    response.should be_success
    videos = assigns( :videos )
    videos.length.should > 0
    
    validate_video assigns( :video )
  end

  #
  #
  #
  private
  
  def validate_video video
    video.should_not eql nil
    video.tasks.length.should >= 1
    
    assert_select ".video-tasks"
    assert_select ".video-tasks .mouseover"
  end
  
end
