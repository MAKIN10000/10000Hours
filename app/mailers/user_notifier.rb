class UserNotifier < ActionMailer::Base
  default :from => "10khourbot@gmail.com"
  
  def send_signup_email(user)
  	@user = user
  	mail(:to => @user.email,
  	:subject => "Thank you for signing up with us!")
  end
end
