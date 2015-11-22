require 'spec_helper'

describe 'Welcome' do

  it 'home' do
    expect( :get => '/manager' ).to route_to( 'manager/welcome#home' )
  end
  
end
