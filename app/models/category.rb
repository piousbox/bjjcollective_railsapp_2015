
class Category

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String

  has_many :videos
  has_many :categories
  belongs_to :category

end

