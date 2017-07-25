require 'spec_helper'
describe Manager::CategoriesController do
  render_views
  before :each do
    setup_categories
    setup_merit_badges
    setup_questsets
    setup_videos
  end

  it '#index' do
    get :index
    response.should be_success
  end

  it '#new' do
    get :new
    response.should be_success
  end

  it '#edit' do
    get :edit, :id => @category.id
    response.should be_success
    assigns( :categories_list ).should_not eql nil
  end

  context '#update' do
    it 'validates kind' do
      raise 'not implemented'
    end
  end
  
end
