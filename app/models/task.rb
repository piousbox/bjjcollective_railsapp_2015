
class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :video_1, :class_name => 'Video', :inverse_of => :task_1
  embedded_in :video_2, :class_name => 'Video', :inverse_of => :task_2
  embedded_in :video_3, :class_name => 'Video', :inverse_of => :task_3

  field :title, :type => String
  field :mouseover, :type => String
  
end
