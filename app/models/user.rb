class User < ActiveRecord::Base
  attr_accessible :user_id, :email, :session_token, :password, :password_confirmation

  before_save { self.email = email.downcase }
  validates :user_id, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  #                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }


  def User::create_user! (hash)
    session = SecureRandom.base64
    hash[:session_token]= session

    User.create!(hash)
  end



  has_secure_password
  #validates :password, length: { minimum: 6 }

end
