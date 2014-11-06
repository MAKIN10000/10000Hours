OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 662977337148851, "ee071a0fba69531b03d0f72b1832cfe4"
end
