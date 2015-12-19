
require 'spec_helper'

describe FightersGuild::WelcomeController do

  render_views
  
  before :each do
    setup_users
    
    MeritBadge.all.each { |m| m.remove }
    @badge = FactoryGirl.create :merit_badge
    photo = Photo.new :shaded_badge => @badge
    photo.save
    photo = Photo.new :accomplished_badge => @badge
    photo.save

    Video.all.each { |v| v.remove }
    @video = Video.create :merit_badge_id => @badge.id, :title => 'some video title', :youtube_id => '1234567890a'
  end
  
  it '#home - not signed in' do
    get :home
    response.should be_success
    response.should render_template( 'fighters_guild/welcome/home' )
    assigns( :badges ).should_not eql nil
    assigns( :questsets ).should_not eql nil
  end

  describe 'home - signed in' do
    before :each do
      setup_questsets      
      sign_in :user, @user
      get :home
    end

    it 'renders' do
      response.should be_success
      questsets = assigns( :questsets )
    end
    
  end
  
  describe 'questsets at #home' do
    before :each do
      sign_out :user
      setup_questsets
      get :home
    end
    
    it 'correct ordering of questsets' do
      questsets = assigns( :questsets )
      questsets.length.should >= 2
      questsets.each_with_index do |q, idx|
        break unless questsets[idx+1]
        # break if idx + 1 == questsets.length
        questsets[idx].order_value.should < questsets[idx+1].order_value
      end
    end
  end

  describe 'accomplished' do
    before :each do
      @badge.title = 'Accomplished Title'
      @badge.save
      
      pv = PlayerVideo.new :video_id => @video.id, :user_id => @user.id
      pv.save
    end
    
    it 'home - accomplished, 1 video' do
      sign_in :user, @user
      get :home
      response.should be_success
      assert_select('.is_accomplished')
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
