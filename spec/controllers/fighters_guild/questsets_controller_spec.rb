
require 'spec_helper'

describe FightersGuild::QuestsetsController do

  before :each do
    setup_questsets
    setup_merit_badges
    setup_videos
  end

  it '#show' do
    get :show, :id => @questset.id
    response.should be_success
    response.should render_template( 'fighters_guild/questsets/show' )
    assigns( :questset ).should_not eql nil
  end
  
end
