
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :merit_badge

  field :title, :type => String
  field :mouseover, :type => String
  
end
