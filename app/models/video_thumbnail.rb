
class VideoThumbnail < ActiveRecord::Base

  self.table_name = :tbx_video_thumbnail
  self.primary_key = :thumbnail_id
  
  belongs_to :video_legacy
  
end
