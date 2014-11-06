class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :email, :name, :image, :session_token, :password, :confirm_password

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
      user.user_id = auth.extra.username
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.session_token = auth.credentials.token
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
