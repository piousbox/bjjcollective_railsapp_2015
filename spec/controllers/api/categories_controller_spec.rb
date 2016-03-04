
require 'spec_helper'

describe Api::CategoriesController do

  render_views
  
  before :each do
    setup_categories
  end

  it 'index_shallow' do
    get :index_shallow, :format => :json
    response.should render_template 'api/categories/index_shallow'
  end

  it 'show_simple_expanded' do
    false.should eql true
  end
  
end
