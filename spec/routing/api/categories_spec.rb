require 'spec_helper'

describe 'Categories' do

  it 'real home' do
    expect( :get => '/api' ).to route_to( 'api/api#home' )
  end
  
  it 'home' do
    expect( :get => '/api/categories.json' ).to route_to( 'api/categories#index_shallow', :format => 'json' )
  end

  it 'two levels down' do
    expect( :get => '/api/categories/slug1/slug2.json' ).to route_to( 'api/categories#index_shallow', :slug => 'slug1', :slug_0 => 'slug2', :format => 'json' )
  end
  
end
