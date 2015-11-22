require 'spec_helper'

describe 'Merit Badges' do

  it 'show' do
    expect( :get => '/fighters_guild/merit_badges/some-id' ).to route_to( 'fighters_guild/merit_badges#show', :id => 'some-id' )
  end

end
