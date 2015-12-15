
require 'spec_helper'

describe FightersGuild::PlayerVideosController do

  render_views
  
  before :each do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @user_2 = FactoryGirl.create :user_2
    sign_in :user, @user

    Questset.all.each { |q| q.remove }
    @questset = FactoryGirl.create :questset
    
    Video.all.each { |v| v.remove }
    @video_for_questset = Video.create( :title => 'Video for questset', :questset => @questset )
    @video_for_questset.tasks << Task.new( :title => 'New Task', :mouseover => 'xxmouseoverxx' )
    @video_for_questset.save.should eql true
    @video_for_questset.tasks[0].should_not eql nil
    @v = @video_for_questset
    
    PlayerVideo.all.each { |pv| pv.remove }
    @player_video = PlayerVideo.create :user_id => @user.id, :video_id => @video_for_questset.id
    @player_video_2 = PlayerVideo.create :user_id => @user_2.id, :video_id => @video_for_questset.id
  end

  it "won't update unless signed in" do
    sign_out :user
    post :update, :id => @player_video.id, :task_id => @video_for_questset.tasks[0].id
    response.should be_redirect
    response.should redirect_to new_user_registration_path
  end

  it "won't update for player_video that I don't own." do
    post :update, :id => @player_video_2.id
    response.should be_redirect
    response.should redirect_to new_user_registration_path
  end
  
  it "will update to complete, will update to undo" do
    @player_video.tasks.should eql []
    post :update, :id => @player_video.id, :task_id => @v.tasks[0].id.to_s, :commit => 'Complete'
    
    result = PlayerVideo.find @player_video.id
    result.tasks.length.should eql 1
    
    post :update, :id => @player_video.id, :task_id => @v.tasks[0].id.to_s, :commit => 'Undo'

    result = PlayerVideo.find @player_video.id
    result.tasks.length.should eql 0
  end
  
end
