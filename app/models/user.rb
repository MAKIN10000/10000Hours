class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :email, :name, :image, :token, :session_token, :password, :password_confirmation

  before_save { self.email = email.downcase }
  validates :user_id, presence: true, length: { maximum: 50 }, :unless => :provider?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }
  #                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :unless => :provider?


  def self.omniauth2(auth)
    pass = SecureRandom.base64
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      hash= {
        :provider => auth.provider, 
        :uid => auth.uid, 
        :user_id => auth.extra.raw_info.username,  
        :email => auth.info.email,
        :name => auth.info.name,
        :image => auth.info.image,
        :token => auth.credentials.token,
        :password => pass,
        :password_confirmation => pass,
        :session_token => SecureRandom.base64
      }
    end
  end
  def self.omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_id = auth.info.nickname
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.password = user.password_confirmation = SecureRandom.base64 
      user.session_token = SecureRandom.base64
    end
  end


  def User::create_user! (hash)
    session = SecureRandom.base64
    hash[:session_token]= session
    User.create!(hash)
  end

 has_secure_password
  #validates :password, length: { minimum: 6 }
end
