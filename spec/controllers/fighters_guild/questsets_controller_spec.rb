
require 'spec_helper'

describe FightersGuild::QuestsetsController do

  render_views
  
  before :each do
    setup_users
    
    setup_questsets
    
    setup_merit_badges
    
    setup_videos
    @video_for_questset.questset = @questset
    @video_for_questset.save
  end

  describe "#show" do
    it 'not logged in' do
      sign_out :user
    
      get :show, :id => @questset.id
      response.should be_success
      response.should render_template( 'fighters_guild/questsets/show' )
      @questset.id.should_not eql nil
      assigns( :questset ).should_not eql nil
      videos = assigns( :videos )
      videos.each do |v|
        v.questset_id.should eql @questset.id
        v.merit_badge_id.should eql nil
      end
    end

    it 'logged in' do
      sign_in :user, @user

      get :show, :id => @questset.id
      response.should be_success
      response.should render_template( 'fighters_guild/questsets/show' )
    end

    it "orders videos by order_value" do
      get :show, :id => @questset.id
      videos = assigns( :videos )
      videos.length.should > 1
      videos.each_with_index do |video, idx|
        break if idx+1 == videos.length
        videos[idx].order_value.should >= videos[idx+1]
      end
    end
  end
  
end
