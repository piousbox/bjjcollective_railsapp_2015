
require 'spec_helper'

describe VideosController do

  render_views
  
  before :each do
    setup_categories
    setup_videos
  end

  it "#legacy_show" do
    get :legacy_show, :legacy_id => @video.legacy_id
    response.should be_redirect
    response.should redirect_to :action => :video, :controller => :categories, :id => @video.id
  end
  
end
