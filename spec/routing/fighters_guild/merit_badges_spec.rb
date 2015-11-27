require 'spec_helper'

describe 'Merit Badges' do

  it 'show' do
    expect( :get => '/fighters_guild/merit_badges/1111' ).to route_to( 'fighters_guild/merit_badges#show', :id => '1111' )
  end

end
