require 'spec_helper'
describe Manager::SitemapsController do
  render_views
  before :each do
  end

  it '#show (1.xml)' do
    get :show
    result = Hash.from_xml(response.body)
    puts! result, 'result'
  end
  
end
