
class CategoryLegacy < ActiveRecord::Base

  self.table_name = :tbx_category
  self.primary_key = :category_id

  has_many :video_legacies, :foreign_key => :category_id
  
end

