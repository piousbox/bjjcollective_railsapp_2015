
class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :youtube_id, :type => String
  field :title,      :type => String
  field :descr,      :type => String
  
  embeds_one :task_1, :class_name => 'Task', :inverse_of => :video_1
  embeds_one :task_2, :class_name => 'Task', :inverse_of => :video_2
  embeds_one :task_3, :class_name => 'Task', :inverse_of => :video_3
  
end
