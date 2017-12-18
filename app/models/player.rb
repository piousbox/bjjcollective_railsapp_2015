
class Player
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  has_many :mastered_videos, :class_name => 'Video', :inverse_of => :mastered_player
  has_many :todo_videos,     :class_name => 'Video', :inverse_of => :todo_player
  
  has_many :player_videos
  has_many :player_badges

end
