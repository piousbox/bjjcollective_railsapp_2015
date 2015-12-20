require 'spec_helper'

describe 'Categories' do

  it 'legacy_show' do
    expect( :get => '/video/333' ).to route_to( 'videos#legacy_show', :legacy_id => '333' )
  end

end



