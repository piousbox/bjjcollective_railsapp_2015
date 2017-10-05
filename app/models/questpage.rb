
class Questpage

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :slug
  field :subtitle
  field :description

  has_many :questsets
  has_many :merit_badges
  
  def self.list
    out = self.order_by( :title => :asc )
    [['', nil]] + out.map { |item| [ item.title, item.id ] }
  end
  
end
