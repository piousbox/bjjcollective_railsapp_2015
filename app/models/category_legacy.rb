
class Category < ActiveRecord::Base

  self.table_name = :tbx_category
  self.primary_key = :category_id

  has_many :videos
  
end

