
class Badge
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,                     :type => String
  field :subhead,                   :type => String
  field :descr,                     :type => String
  field :shaded_mouseover,          :type => String
  field :accomplished_mouseover,    :type => String
  field :order_value,               :type => String, :default => "jjj"

  embeds_many :tasks
  
  embeds_one :shaded_photo,       :class_name => 'Photo', :inverse_of => :shaded_badge
  embeds_one :accomplished_photo, :class_name => 'Photo', :inverse_of => :accomplished_badge
  embeds_one :title_photo,        :class_name => 'Photo', :inverse_of => :title_badge
  embeds_one :unavailable_photo,  :class_name => 'Photo', :inverse_of => :unavailable_badge
  
  has_many :videos

  def self.list
    out = self.order_by( :title => :asc )
    [['', nil]] + out.map { |item| [ item.title, item.id ] }
  end
  
end
