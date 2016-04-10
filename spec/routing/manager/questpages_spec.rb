require 'spec_helper'

describe 'Questpages' do

  it 'index' do
    expect( :get => '/manager/questpages' ).to route_to( 'manager/questpages#index' )
  end
  
  it 'new' do
    expect( :get => '/manager/questpages/new' ).to route_to( 'manager/questpages#new' )
  end
  
end
