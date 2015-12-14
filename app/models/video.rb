
class Video
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :youtube_id,   :type => String
  field :title,        :type => String
  field :descr,        :type => String
  field :order_value,  :type => String, :default => "jjj"

  embeds_many :tasks

  # @TODO: this should instead be a polymorphic relationship
  belongs_to :merit_badge
  belongs_to :questset
  
  has_many :player_videos

end
