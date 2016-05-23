
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

  context '#show - signed in' do
    before :each do
      sign_in :user, @user
      get :show, :id => @questpage.id
    end
    
    it 'does' do
      response.should be_success
      response.should render_template( 'fighters_guild/questpages/show' )
    end
  end

end
