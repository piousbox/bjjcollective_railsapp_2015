
class MeritBadge
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                     :type => String
  field :subhead,                   :type => String
  field :descr,                     :type => String
  field :shaded_mouseover,          :type => String
  field :accomplished_mouseover,    :type => String

  embeds_many :tasks
  
  has_one :shaded_photo,       :class_name => 'Photo', :inverse_of => :shaded_badge
  has_one :accomplished_photo, :class_name => 'Photo', :inverse_of => :accomplished_badge
  has_one :title_photo,        :class_name => 'Photo', :inverse_of => :title_badge
end
