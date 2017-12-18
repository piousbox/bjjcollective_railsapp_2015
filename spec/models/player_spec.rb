require 'spec_helper'
describe Player do
  before :each do
    User.all.destroy
    @user = FactoryGirl.create :user
    setup_players
  end
  
  describe 'todo list' do
    it 'sanity' do
      @player.todo_videos.to_a.should eql []
    end
  end

  describe 'mastered list' do
    it 'sanity' do
      @player.mastered_videos.to_a.should eql []
    end
  end

end

