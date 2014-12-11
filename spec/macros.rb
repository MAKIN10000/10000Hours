module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:facebook] = {
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'image' => 'mock_user_thumbnail_url',
        'email' => 'mock_user@email.com',
        'first_name' => 'Mock'

      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }
  end
end
