
require 'spec_helper'

describe CategoriesController do

  render_views
  
  before :each do
    setup_categories
  end

  describe "#home" do
    it 'renders' do
      get :home
      response.should render_template 'categories/home'
    end
  end

  it "index" do
    get :index
    response.should render_template "categories/index_2"
    assigns( :categories ).should_not eql nil
  end

  describe "show" do
    it 'does' do
      get :show, :slug => @category.slug
      response.should render_template 'categories/show'
      
      assigns( :categories ).should_not eql nil
      assigns( :category   ).should_not eql nil
      assigns( :videos     ).should_not eql nil
    end
  end
  
end
