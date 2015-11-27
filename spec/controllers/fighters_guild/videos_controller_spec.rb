
require 'spec_helper'

describe FightersGuild::VideosController do

  before :each do
    MeritBadge.all.each { |b| b.remove }
    @badge = FactoryGirl.create :badge
   
    Video.all.each { |v| v.remove }
    @video = FactoryGirl.create :video
    @video.merit_badge = @badge
    @video.save
    
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    
    sign_in :user, @user
  end

  it '#show' do
    get :show, :id => @video.id
    response.should be_success
    response.should render_template( 'fighters_guild/videos/show' )
    assigns( :video ).should_not eql nil
    assigns( :badge ).should_not eql nil
  end
  
end
