
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :video
  belongs_to :badge

  field :title, :type => String
  field :mouseover, :type => String
  
end
