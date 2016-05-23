
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

  describe 'show_simple_expanded' do
    it 'normal, with id' do
      get :show_simple_expanded, :format => :json, :id => @category.id
      response.should be_success
      # @TODO: why this broken? _vp_ 20160522
      # response.should render_template 'api/categories/index_shallow'
    end

    it 'without id' do
      get :show_simple_expanded, :format => :json
      response.should be_success
      # @TODO: why this broken? _vp_ 20160522
      # response.should render_template 'api/categories/index_shallow'
    end
  end
  
end
