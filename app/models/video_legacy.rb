
class VideoLegacy < ActiveRecord::Base

  self.table_name = :tbx_video
  self.primary_key = :video_id

  belongs_to :category
  has_one :video_clip
  has_one :video_thumbnail
  
end
