
class Photo

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :user, :inverse_of => :photos
  validates :user, :presence => true
  
  field :name, :type => String
  field :descr, :type => String

  has_mongoid_attached_file :photo, 
    :styles => {
    :mini => '20x20#',
    :thumb => "100x100#",
    # :two_hundred => '200x200#',
    :small  => "400x400>",
    # :small_square => "400x400#",
    :large => '950x950>'
  },
    :storage => :s3,
    :s3_credentials => ::S3_CREDENTIALS,
    :path => "photos/:style/:id/:filename"

  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  set_callback(:create, :before) do |doc|
#    if doc.is_public
#      Site.languages.each do |lang|
#        n = Newsitem.new({
#            # :descr => t('photos.new'),
#            :photo => doc, :username => doc.user.username })
#        Site.where( :domain => DOMAIN, :lang => lang ).first.newsitems << n
#      end
#    end
  end
  
end

