require 'spec_helper'

describe 'Welcome - generic' do

  it 'home' do
    expect( :get => '/manager' ).to route_to( 'manager/welcome#home' )
  end

  it 'one sitemap' do
    expect( :get => '/manager/sitemap.xml' ).to route_to( 'manager/sitemaps#show' )
  end
  
end
