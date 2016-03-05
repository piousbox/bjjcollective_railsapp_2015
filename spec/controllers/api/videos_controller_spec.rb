
require 'spec_helper'

describe Api::VideosController do

  render_views
  
  before :each do
    setup_categories
    setup_videos
  end

  describe 'index' do
    it 'with category id' do
      get :index, :format => :json, :category_id => @category.id
      response.should be_success
      assigns( :videos ).should_not eql nil
    end
    it 'with videos page' do
      get :index, :format => :json, :category_id => @category.id, :videos_page => 2
      response.should be_success
      assigns( :videos ).should_not eql nil
    end
  end
  
end
