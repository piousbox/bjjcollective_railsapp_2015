
#
# Let's call this location tentatively...
#

class Questset < Badge

  field :is_questset, :type => Boolean, :default => true

  field :location_name, :type => String
  index({ :location_name => 1 }, { :unique => true })

  attr_accessor :is_unavailable

  has_many :videos
  
end

