
require 'spec_helper'

describe FightersGuild::MeritBadgesController do

  before :each do
    MeritBadge.all.each { |m| m.remove }
    @badge = FactoryGirl.create :merit_badge
  end

  it '#show' do
    get :show, :id => MeritBadge.all.first.id
    response.should be_success
    response.should render_template( 'fighters_guild/merit_badges/show' )
    assigns( :badge ).should_not eql nil
  end
  
end
