
require 'spec_helper'

describe FightersGuild::VideosController do

  before :each do
    Video.all.each { |v| v.remove }
    @video = FactoryGirl.create :video
  end

  it '#show' do
    get :show, :id => @video.id
    response.should be_success
    response.should render_template( 'fighters_guild/videos/show' )
    assigns( :video ).should_not eql nil
  end
  
end
