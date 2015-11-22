
class MeritBadge
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                     :type => String
  field :subhead,                   :type => String
  field :descr,                     :type => String
  field :shaded_mouseover,          :type => String
  field :accomplished_mouseover,    :type => String

  embeds_many :tasks
  
  embeds_one :shaded_photo,       :class_name => 'Photo', :inverse_of => :shaded_badge
  embeds_one :accomplished_photo, :class_name => 'Photo', :inverse_of => :accomplished_badge
  embeds_one :title_photo,        :class_name => 'Photo', :inverse_of => :title_badge

  embeds_one :task_1, :class_name => 'Task', :inverse_of => :merit_badge_1
  embeds_one :task_2, :class_name => 'Task', :inverse_of => :merit_badge_2
  embeds_one :task_3, :class_name => 'Task', :inverse_of => :merit_badge_3

end
