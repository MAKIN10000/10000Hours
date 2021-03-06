class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :email, :name, :first, :image, :token, :session_token, :role, :password, :password_confirmation

  before_save { self.email = email.downcase }
  validates :user_id, presence: true, length: { maximum: 50 }, :unless => :provider?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }
  #                  uniqueness: { case_sensitive: false }
validates :password, length: { minimum: 6 }, :unless => Proc.new {|user| user.password.nil? || user.provider?}

  has_many :goals, dependent: :destroy

  def self.omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.first = auth.info.first_name
      user.image = auth.info.image + "?type=large"
      user.token = auth.credentials.token
      user.password = user.password_confirmation = SecureRandom.base64 
      user.session_token = SecureRandom.base64
    end
  end


  def self.create_user! (hash)
    session = SecureRandom.base64
    uid = SecureRandom.uuid + hash[:user_id]
    hash[:session_token]= session
    hash[:uid] = uid
    hash[:name] = hash[:user_id]
    hash[:image]= "/images/no-icon.jpg"
    User.create!(hash)
  end

 has_secure_password
  #validates :password, length: { minimum: 6 }
end
