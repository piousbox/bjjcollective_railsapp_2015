require 'spec_helper'

describe 'Fighters Guild' do

  it 'root' do
    expect( :get => '/fighters-guild' ).to route_to( 'fighters_guild/welcome#home' )
  end

end
