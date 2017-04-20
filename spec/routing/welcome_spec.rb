require 'spec_helper'

describe 'Welcome' do

  # root is controller categories

  it 'donate' do
    expect( :get => '/donate' ).to route_to( 'welcome#donate' )
  end

end
