
class MeritBadge
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :descr, :type => String
  
  has_one :shaded_photo, :class_name => 'Photo', :inverse_of => :shaded_badge
  has_one :accomplished_photo, :class_name => 'Photo', :inverse_of => :accomplished_badge
       
end
