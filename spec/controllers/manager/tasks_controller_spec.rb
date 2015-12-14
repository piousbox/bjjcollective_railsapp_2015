
require 'spec_helper'

describe Manager::TasksController do

  render_views
  
  before :each do
    setup_merit_badges
    
    setup_questsets

    Video.all.each { |v| v.remove }
    @video = Video.create
    @video.merit_badge_id = @merit_badge.id
    @video.save.should eql true
  end

  describe 'for video in merit badge / questset' do
    before :each do
      @video.id.should_not eql nil
      @video.tasks.length.should eql 0
    end
    
    it '#create' do  
      post :create, :task => { :title => 'xxtitlexx', :mouseover => 'xxmouseover' }, :video_id => @video.id

      result = Video.find @video.id
      result.tasks.length.should eql 1
      result.tasks[0].title.should eql 'xxtitlexx'
    end
  end
  
  
end
