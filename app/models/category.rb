
class Category

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,         :type => String # validates_uniqueness_of :title # This cannot be done without scope as there are many subcategories "Top"
  field :slug,          :type => String,  :default => ""
  validates_uniqueness_of :slug
  field :short_slug,    :type => String
  field :subhead,       :type => String
  field :descr,         :type => String

  field :is_simple,     :type => Boolean, :default => false
  field :is_top,        :type => Boolean, :default => true
  field :order_value,   :type => String,  :default => 'jjj'
  
  has_many    :videos
  has_many    :categories
  belongs_to  :category
  embeds_one  :photo

end

