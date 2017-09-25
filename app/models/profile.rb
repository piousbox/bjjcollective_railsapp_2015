
class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user

  field :email
  field :fb_access_token
  field :name

end
