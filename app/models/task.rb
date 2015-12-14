
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :video
  embedded_in :player_video

  field :title, :type => String
  field :mouseover, :type => String
  
end
