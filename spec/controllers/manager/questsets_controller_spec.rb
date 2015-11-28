
require 'spec_helper'

describe Manager::QuestsetsController do

  before :each do
    Questset.all.each { |q| q.remove }
    @questset = FactoryGirl.create :questset
  end

  it '#index' do
    get :index
    response.should be_success
    response.should render_template( 'manager/questsets/index' )
    assigns( :questsets ).should_not eql nil
  end

  it '#new' do
    get :new
    response.should be_success
    response.should render_template( 'manager/questsets/new' )
    assigns( :questset ).should_not eql nil
  end

  it '#edit' do
    get :edit, :id => @questset.id
    response.should be_success
    response.should render_template( 'manager/questsets/edit' )
    assigns( :questset ).should_not eql nil
  end
  
end
