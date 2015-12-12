
class Questset < Badge

  field :is_questset, :type => Boolean, :default => true

  attr_accessor :is_unavailable

  has_many :videos
  
end

