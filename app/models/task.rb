
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :merit_badge_1, :class_name => 'MeritBadge', :inverse_of => :task_1
  embedded_in :merit_badge_2, :class_name => 'MeritBadge', :inverse_of => :task_2
  embedded_in :merit_badge_3, :class_name => 'MeritBadge', :inverse_of => :task_3

  field :title, :type => String
  field :mouseover, :type => String
  
end
