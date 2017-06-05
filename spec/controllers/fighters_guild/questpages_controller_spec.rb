
require 'spec_helper'

describe FightersGuild::QuestpagesController do

  render_views
  
  before :each do
    setup_users

    setup_questpages
    setup_questsets
    Questset.all.each { |q| q.questpage = @questpage; q.save }
  end

  context '#index' do
    it 'does' do
      get :index
      response.should be_success
      response.should render_template( 'fighters_guild/questpages/index' )
    end
  end

  context '#show - not signed in' do
    before :each do
      sign_out :user      
      get :show, :id => @questpage.id
    end
    
    xit 'correct ordering of questsets' do # @TODO
      questsets = assigns( :questsets )
      questsets.length.should >= 2
      questsets.each_with_index do |q, idx|
        break unless questsets[idx+1]
        questsets[idx][:order_value].should < questsets[idx+1][:order_value]
      end
    end
  end

  context '#show - signed in' do
    before :each do
      sign_in :user, @user

      MeritBadge.all.each { |m| m.remove }
      Video.all.each { |v| v.remove }

      # this one is unaccomplished
      @merit_badge_1 = MeritBadge.create({ :title => 'badge 1',
                                           :questpage_id => @questpage.id, :accomplished_order_value => 'accomplished_2', :unaccomplished_order_value => 'unaccomplished_1'
                                         })

      # this one is accomplished by this user
      @merit_badge_2 = MeritBadge.create({ :title => 'badge 2',
                                           :questpage => @questpage, :accomplished_order_value => 'accomplished_1', :unaccomplished_order_value => 'unaccomplished_2'
                                         })
      @video = Video.create :merit_badge_id => @merit_badge_2.id
      @video.tasks << Task.new
      @video.save
      @user.player_videos.each { |p| p.remove }
      @player_video = PlayerVideo.new :user => @user, :video => @video
      @player_video.tasks << @video.tasks[0].id
      @player_video.save.should eql true
      @player_video.tasks.should eql [ @video.tasks[0].id ]
      
      get :show, :id => @questpage.id
    end
    
    it 'renders' do
      response.should be_success
      response.should render_template( 'fighters_guild/questpages/show' )
    end

    it 'has unaccomplished, accomplished ordering' do 
      merit_badges = assigns :badges
      
      merit_badges[0].id.should eql @merit_badge_2.id
      merit_badges[1].id.should eql @merit_badge_1.id

      sign_out :user

      get :show, :id => @questpage.id

      merit_badges = assigns :badges
      merit_badges[0].should eql @merit_badge_1
      merit_badges[1].should eql @merit_badge_2      
    end
  end

end
