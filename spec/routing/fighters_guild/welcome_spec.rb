require 'spec_helper'

describe 'Fighters Guild' do

  it 'root' do
    expect( :get => '/fighters_guild' ).to route_to( 'fighters_guild/welcome#home' )
  end

end
