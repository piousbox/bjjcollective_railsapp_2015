
require 'spec_helper'

describe 'fighters_guild/merit_badges/_list.haml' do
  before :each do
    MeritBadge.all.each { |b| b.remove }
  end
  
  it 'mouseover is not displayed if it is nil or empty string' do
    @merit_badges = [ MeritBadge.create, MeritBadge.create( :shaded_mouseover => '' ) ]
    assign :badges, @merit_badges    
    render
    rendered.should_not match(/mouseover/)
  end

  it 'mouseover displayed if it is not empty' do
    @merit_badges = [ MeritBadge.create( :shaded_mouseover => 'shaded mouseover' ) ]
    assign :badges, @merit_badges
    render
    rendered.should match(/mouseover/)
  end
  
end
