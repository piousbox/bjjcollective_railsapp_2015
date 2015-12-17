require 'spec_helper'

describe 'Welcome' do

  it 'home' do
    expect( :get => '/' ).to route_to( 'welcome#home' )
  end

  it 'categories' do
    expect( :get => '/categories' ).to route_to( 'categories#index' )
  end
  
end
