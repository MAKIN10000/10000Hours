class User < ActiveRecord::Base
  attr_accessible :user_id, :email, :session_token, :password, :password_confirmation

  before_save { self.email = email.downcase }
  validates :user_id, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  #                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }


  def self.omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
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
