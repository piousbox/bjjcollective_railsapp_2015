
class Badge
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                     :type => String
  field :subhead,                   :type => String
  field :descr,                     :type => String

  field :is_questset, :type => Boolean, :default => false

  field :unavailable_mouseover,     :type => String
  field :shaded_mouseover,          :type => String
  field :accomplished_mouseover,    :type => String

  field :unaccomplished_order_value,  :type => String, :default => 'jjj'
  field :accomplished_order_value,    :type => String, :default => 'jjj'
  attr_accessor :order_value
  
  embeds_many :tasks
  
  embeds_one :shaded_photo,       :class_name => 'Photo', :inverse_of => :shaded_badge
  embeds_one :accomplished_photo, :class_name => 'Photo', :inverse_of => :accomplished_badge
  embeds_one :title_photo,        :class_name => 'Photo', :inverse_of => :title_badge
  embeds_one :unavailable_photo,  :class_name => 'Photo', :inverse_of => :unavailable_badge

  embeds_one :background_image,   :class_name => 'Photo', :inverse_of => :bg_badge
  field :background_image_width,  :type => Integer
  field :background_image_height, :type => Integer

  embeds_many :photos,                                    :inverse_of => :badge

  belongs_to :questpage

  belongs_to :badge
  has_many :badges

  field :bg_pos_x, :type => Integer
  field :bg_pos_y, :type => Integer

  field :location_name, :type => String
  index({ :location_name => 1 }, { :unique => true })

  attr_accessor :is_unavailable

  has_many :videos

  def self.list
    out = self.order_by( :title => :asc )
    [['', nil]] + out.map { |item| [ item.title, item.id ] }
  end
  
end
