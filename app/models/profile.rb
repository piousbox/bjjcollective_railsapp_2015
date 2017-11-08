
class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user

  field :name
  field :email
  index({ :email => -1 }, { :unique => true })

  field :fb_access_token
  field :fb_long_access_token # not used, the long-lived token is in :fb_access_token
  field :fb_id
  field :signed_request

  field :n_stars, :type => Integer, :default => 0

  has_many                :created_badges, :class_name => 'Badge', :inverse_of => :created_profile
  has_and_belongs_to_many :bought_badges,  :class_name => 'Badge', :inverse_of => :bought_profiles

  # stripe
  field :stripe_account_id
  index({ :stripe_account_id => -1 }, { :unique => true })

  field :total_money_earned, :type => Float
  field :commission,         :type => Float, :default => 0.15 # percent, 0-1 value

  def self.list
    [['Select...', nil]] + self.all.map { |i| [i.email, i.id] }
  end

end
