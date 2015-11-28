
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
    @questset.id.should_not eql nil
    assigns( :questset ).should_not eql nil
    videos = assigns( :videos )
    videos.each do |v|
      v.questset_id.should eql @questset.id
      v.badge_id.should eql nil
    end
  end
  
end
