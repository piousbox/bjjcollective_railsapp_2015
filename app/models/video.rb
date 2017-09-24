
class Video
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field                   :youtube_id, :type => String
  # validates_uniqueness_of :youtube_id
  # validates_length_of     :youtube_id, :mimimum => 11, :maximum => 11
  
  field :title,        :type => String
  validates :title, :presence => true

  field :descr,        :type => String
  field :order_value,  :type => String, :default => "jjj"
  field :legacy_id,    :type => Integer
  field :tag_string,   :type => String, :default => ''

  field :transcript_url, :type => String
  
  embeds_many :tasks

  # @TODO: this should instead be a polymorphic relationship
  belongs_to :merit_badge
  belongs_to :questset
  # belongs_to :badge # ???
  
  belongs_to :category
  belongs_to :mastered_player, :class_name => 'Player', :inverse_of => :mastered_videos
  belongs_to :todo_player,     :class_name => 'Player', :inverse_of => :todo_videos

  has_many :player_videos

  default_scope proc { order_by( :order_value => 'asc' ) }
  
end
