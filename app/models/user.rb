
class User  
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :profile

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  ## Database authenticatable
  field :email, type: String, default: ""
  validates :email, :presence => true, :uniqueness => true

  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  
  # :recoverable, :trackable :rememberable,
  # :token_authenticatable, 
  # :lockable, :timeoutable, :confirmable
  devise :registerable, :validatable
  devise :database_authenticatable, :authentication_keys => [ :email ]
  # devise :omniauthable, :omniauth_providers => [ :facebook ]
  # devise :encryptable, :encryptor => :sha1base64
  #
  #
  # field :confirmed_at, :type => DateTime
  # field :confirmation_token, :type => String
  # field :confirmation_sent_at, :type => DateTime
  
  # field :username, :type => String
  # validates :username, :presence => true, :uniqueness => true
  
  # field :name, :type => String
  # validates :name, :presence => true
  
  field :group_id, :type => Integer, :default => 3

  has_one :player
  has_many :player_videos

end
