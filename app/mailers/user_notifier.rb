class UserNotifier < ActionMailer::Base
  #include SendGrid  
  default :from => "10khourbot@gmail.com"
  
  def send_signup_email(user)
    @user = user
  	mail(:to => "#{@user.email}", :subject => "Thank you for signing up with us!", template_path: 'Usernotifier')
  end

  def send_goal_email(user)
  	@user = user
  	mail(:to => "#{@user.email}", :subject => "Hey! Just reminding you of your goal", template_path: 'Usernotifier', template_name: 'send_goal_email')
  end
end
