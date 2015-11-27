
class PlayerVideo
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :video

  field :task_1_ok, :type => Boolean, :default => false
  field :task_2_ok, :type => Boolean, :default => false
  field :task_3_ok, :type => Boolean, :default => false
  
end
