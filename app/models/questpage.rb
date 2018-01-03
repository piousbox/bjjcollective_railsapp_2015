
class Questpage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :slug
  field :subtitle
  field :description

  field :is_trash, :type => Boolean, :default => false
  field :is_active, :type => Boolean, :default => true

  has_many :questsets
  has_many :merit_badges
  
  def self.list
    out = self.order_by( :title => :asc )
    [['', nil]] + out.map { |item| [ item.title, item.id ] }
  end
  
end
