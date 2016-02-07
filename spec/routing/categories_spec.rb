require 'spec_helper'

describe 'Categories' do

  it 'home' do
    expect( :get => '/' ).to route_to( 'welcome#home' )
  end

  it 'show' do
    expect( :get => '/categories/view/some-category' ).to route_to( 'categories#show', :slug => 'some-category' )
    expect( :get => '/categories/123' ).to route_to( 'categories#show', :id => '123' )
  end

  it 'video' do
    expect( :get => '/videos/123' ).to route_to( 'categories#video', :id => '123' )
  end
  
end
