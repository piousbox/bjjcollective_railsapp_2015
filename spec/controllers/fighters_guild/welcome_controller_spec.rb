
require 'spec_helper'

describe FightersGuild::WelcomeController do

  before :each do
    ;
  end

  it '#home' do
    get :home
    response.should be_success
    response.should render_template( 'fighters_guild/welcome/home' )
    assigns( :badges ).should_not eql nil
    assigns( :questsets ).should_not eql nil
  end
  
end
