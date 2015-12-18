
class VideoLegacy < ActiveRecord::Base

  self.table_name = :tbx_video
  self.primary_key = :video_id

  belongs_to :category_legacy,   :foreign_key => :video_id
  has_one :video_clip,           :foreign_key => :video_id
  has_one :video_thumbnail,      :foreign_key => :video_id
  
end
