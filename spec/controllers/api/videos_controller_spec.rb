
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

  describe 'show' do
    it 'show_one' do
      get :show_one, :id => @video.id, :format => :json
      response.should be_success
      response.should render_template('videos/show_one')
      assigns( :video ).should_not eql nil
    end
  end
  
end
