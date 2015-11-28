require 'spec_helper'

describe 'Questsets' do

  it 'index' do
    expect( :get => '/manager/questsets' ).to route_to( 'manager/questsets#index' )
  end
  
end
