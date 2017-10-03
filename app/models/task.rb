
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  # embedded_in :player_video
  # embedded_in :badge
  belongs_to :video
  belongs_to :badge

  field :title, :type => String
  field :mouseover, :type => String
  
end
