require 'rails_helper'

describe UsersController do
  describe 'Register' do
    context 'user exists'
    it 'should render register page' do
      expect(User).to receive(:exists?).and_return(true)
      post :create, :user=>{:user_id=> "nick",:password=> "filmcrew", :password_confirmation=>"filmcrew", :email=>"user@email.com"}
      expect(response).to redirect_to('/users/new')
    end
    context 'user doesnt exist, but is not valid'
    it 'should redirect to registration page' do
      post :create, :user=>{:user_id=> "nick2",:password=> "firew", :password_confirmation=>"filcrew", :email=>"user@email.com"}
      expect(response).to redirect_to('/users/new')
    end
    context 'user doesnt exist, and is valid'
    it 'should call the create method of User' do
      user = double(User)
      allow(user).to receive(:email)
      expect(User).to receive(:create!).and_return(user)
      allow(user).to receive(:user_id)
      post :create, :user=>{:user_id=> "nick3",:password=> "filmscrew", :password_confirmation=>"filmscrew", :email=>"user@email.com"}
    end
    it 'should select the login_path to render' do
      user = double(User)
      allow(user).to receive(:user_id)
      expect(User).to receive(:create!).and_return(user)
      post :create, :user=>{:user_id=> "nick4",:password=> "filmscrew", :password_confirmation=>"filmscrew", :email=>"user@email.com"}
      expect(response).to redirect_to('/login')
    end
  end
end

