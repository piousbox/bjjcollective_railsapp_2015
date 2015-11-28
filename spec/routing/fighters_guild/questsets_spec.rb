require 'spec_helper'

describe 'Questsets' do

  it 'show' do
    expect( :get => '/fighters_guild/questsets/some-id' ).to route_to( 'fighters_guild/questsets#show', :id => 'some-id' )
  end

end
