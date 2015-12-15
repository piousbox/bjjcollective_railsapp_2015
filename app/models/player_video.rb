
class PlayerVideo
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :video

  field :tasks, :type => Array, :default => []
  
  # attr_accessor :tasks_hash

end
