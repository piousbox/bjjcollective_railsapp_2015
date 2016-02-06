
require 'spec_helper'

describe Api::CategoriesController do

  render_views
  
  it 'home' do
    get :home
    response.should be_success
  end
  
end
