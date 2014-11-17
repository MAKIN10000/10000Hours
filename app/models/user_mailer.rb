class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
  	@message = "Welcome to the 10,000 Hour Project!"
  	mail(:from => "10khourbot@gmail.com", :to => "mjayjones13@gmail.com", :subject => "Thank you for joining us!")
  end
end
