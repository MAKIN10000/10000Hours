# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tenkhours::Application.initialize!

ActionMailer::Base.smtp_settings = {
	:user_name => "10khourbot@gmail.com",
	:password => "deadline13",
	:domain => "www.gmail.com",
	:address => "smtp.sendgrid.net",
	:port => 587,
	:authentication => 'plain',
	:enable_starttls_auto => true
}
