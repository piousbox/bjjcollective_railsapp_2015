require 'spec_helper'

describe 'Categories' do

  it 'real home' do
    expect( :get => '/api' ).to route_to( 'api/api#home' )
  end
  
  it 'home' do
    expect( :get => '/api/categories.json' ).to route_to( 'api/categories#index_shallow', :format => 'json' )
  end
  
end
