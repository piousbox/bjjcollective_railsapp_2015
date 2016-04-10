
require 'spec_helper'

describe Questpage do

  before :each do
    # setup_users
    # setup_players
    @qp = Questpage.new
  end
  
  describe 'all' do
    it 'sanity' do
      @qp.class.name.should eql 'Questpage'
    end
  end

end

