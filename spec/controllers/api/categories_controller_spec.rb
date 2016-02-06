
require 'spec_helper'

describe Api::CategoriesController do

  render_views
  
  before :each do
    setup_categories
  end

  it 'index' do
    get :index, :format => :json
    response.should render_template 'api/categories/index'
  end
  
end
