
require 'spec_helper'

describe Manager::QuestsetsController do

  render_views
  
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
    expect(response.body).to have_tag( "body" )
    expect(response.body).to have_tag( "#questset_unavailable_mouseover" )
    assigns( :questset ).should_not eql nil
  end

  it '#edit' do
    get :edit, :id => @questset.id
    response.should be_success
    response.should render_template( 'manager/questsets/edit' )
    assigns( :questset ).should_not eql nil
  end

  it '#update' do
    patch :update, :id => @questset.id, :questset => { :unavailable_mouseover => 'xxunavailable_mouseoverxx' }
    result = Questset.find @questset.id
    result.unavailable_mouseover.should eql 'xxunavailable_mouseoverxx'
  end

  describe 'updates' do
    it 'order_value' do
      @questset.order_value.should eql 'jjj'
      post :update, :id => @questset.id, :questset => { :order_value => 'aaa' }
      result = Questset.find @questset.id
      result.order_value.should eql 'aaa'
    end
  end
  
end
