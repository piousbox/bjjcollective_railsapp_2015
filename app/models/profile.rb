
class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user

  field :name
  field :email

  field :fb_access_token
  field :fb_long_access_token
  field :fb_id
  field :signed_request

  field :n_stars, :type => Integer, :default => 0

end
