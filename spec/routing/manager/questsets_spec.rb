require 'spec_helper'

describe 'Questsets' do

  it 'index' do
    expect( :get => '/manager/questsets' ).to route_to( 'manager/questsets#index' )
  end
  
  it 'new' do
    expect( :get => '/manager/questsets/new' ).to route_to( 'manager/questsets#new' )
  end
  
end
