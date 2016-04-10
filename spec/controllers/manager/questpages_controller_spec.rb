
require 'spec_helper'

describe Manager::QuestpagesController do

  render_views
  
  before :each do
    Questpage.all.each { |q| q.remove }
    @questpage = FactoryGirl.create :questpage
  end

  it '#index' do
    get :index
    response.should be_success
    response.should render_template( 'manager/questpages/index' )
    assigns( :questpages ).should_not eql nil
  end

  it '#new' do
    get :new
    response.should be_success
    response.should render_template( 'manager/questpages/new' )
    expect(response.body).to have_tag( "body" )
    assigns( :questpage ).should_not eql nil
  end

  it '#edit' do
    get :edit, :id => @questpage.id
    response.should be_success
    response.should render_template( 'manager/questpages/edit' )
    assigns( :questpage ).should_not eql nil
  end

  it '#update' do
    # patch :update, :id => @questpage.id, :questpage => { :unavailable_mouseover => 'xxunavailable_mouseoverxx' }
    # result = Questpage.find @questpage.id
    # result.unavailable_mouseover.should eql 'xxunavailable_mouseoverxx'
  end
  
end
