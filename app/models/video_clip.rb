
class VideoClip < ActiveRecord::Base

  self.table_name = :tbx_video_clip
  self.primary_key = :clip_id
  self.inheritance_column = :model_type
  
  belongs_to :video_legacy
  
end
