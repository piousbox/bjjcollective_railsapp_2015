
require 'spec_helper'

describe FightersGuild::PlayerVideosController do

  render_views
  
  before :each do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user    
    sign_in :user, @user

    Questset.all.each { |q| q.remove }
    @questset = FactoryGirl.create :questset
    
    Video.all.each { |v| v.remove }
    @video_for_questset = Video.create( :title => 'Video for questset', :questset => @questset )

    PlayerVideo.all.each { |pv| pv.remove }
    @player_video = PlayerVideo.create :user_id => @user.id, :video_id => @video_for_questset.id
    puts! @player_video.errors, 'errors of pv'
  end

  it 'update' do
    @player_video.task_1_ok.should eql false
    
    post :update, :id => @player_video.id, :task_1_ok => "true"

    result = PlayerVideo.find @player_video.id
    result.task_1_ok.should eql true

    post :update, :id => @player_video.id, :task_1_ok => "false", :task_2_ok => "true"
    result = PlayerVideo.find @player_video.id
    result.task_1_ok.should eql false
    result.task_2_ok.should eql true
  end
  
end
