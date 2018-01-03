require 'spec_helper'
describe Api::QuestpagesController do
  render_views
  before :each do
    setup_questpages
    setup_categories
    setup_videos
  end

  describe 'index' do
    it 'does not show trash' do
      trash = FactoryGirl.create :questpage, :is_trash => true, :title => 'trash questpage'
      Questpage.count.should >= 2
      get :index, :format => :json
      results = JSON.parse response.body
      results = results.map{ |r| r['title'] }
      results.include?( 'trash questpage' ).should eql false
    end
  end

end
