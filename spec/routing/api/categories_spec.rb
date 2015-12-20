require 'spec_helper'

describe 'Categories' do

  it 'home' do
    expect( :get => '/api/categories.json' ).to route_to( 'api/categories#index', :format => 'json' )
  end
  
end
