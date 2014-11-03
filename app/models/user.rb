class User < ActiveRecord::Base
  attr_accessible :user_id, :email, :session_token
  
  def User::create_user! (hash)
    session = SecureRandom.base64
    hash[:session_token]= session
    create!(hash)
  end
end
