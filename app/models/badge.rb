
class Badge
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                     :type => String
  field :subhead,                   :type => String
  field :descr,                     :type => String

  field :unavailable_mouseover,     :type => String
  field :shaded_mouseover,          :type => String
  field :accomplished_mouseover,    :type => String

  field :unaccomplished_order_value,  :type => String, :default => 'jjj'
  field :accomplished_order_value,  :type => String, :default => 'jjj'
  attr_accessor :order_value
  
  embeds_many :tasks
  
  embeds_one :shaded_photo,       :class_name => 'Photo', :inverse_of => :shaded_badge
  embeds_one :accomplished_photo, :class_name => 'Photo', :inverse_of => :accomplished_badge
  embeds_one :title_photo,        :class_name => 'Photo', :inverse_of => :title_badge
  embeds_one :unavailable_photo,  :class_name => 'Photo', :inverse_of => :unavailable_badge
  embeds_many :photos,                                    :inverse_of => :badge
  
  # has_many :videos # @TODO: why can't this be here?

  belongs_to :questpage
  
  def self.list
    out = self.order_by( :title => :asc )
    [['', nil]] + out.map { |item| [ item.title, item.id ] }
  end
  
end
