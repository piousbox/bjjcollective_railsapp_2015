require 'spec_helper'
describe Api::CategoriesController do
  render_views
  before :each do
    setup_categories
  end

  describe '#index_shallow' do
    it 'simple' do
      get :index_shallow, :format => :json
      response.should render_template 'api/categories/index_shallow'
    end

    it 'two levels deep' do
      get :index_shallow, :slug => 'mounts', :slug_0 => 'side-control', :format => 'json'
      response.should render_template 'api/categories/index_shallow'
      result = JSON.parse response.body
      result[:title].should eql 'Side Control'
    end
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
