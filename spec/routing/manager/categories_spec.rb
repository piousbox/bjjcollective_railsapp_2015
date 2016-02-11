require 'spec_helper'

describe 'Categories' do

  it 'index' do
    expect( :get => '/manager/categories' ).to route_to( 'manager/categories#index' )
  end

  it 'new' do
    expect( :get => '/manager/categories/new' ).to route_to 'manager/categories#new'
  end
  
end
