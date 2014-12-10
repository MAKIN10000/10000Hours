require 'rails_helper'

describe UsersController do
  describe 'Register' do
    context 'user exists' do
      it 'should render register page' do
        expect(User).to receive(:exists?).and_return(true)
        post :create, :user=>{:user_id=> "nick",:password=> "filmcrew", :password_confirmation=>"filmcrew", :email=>"user@email.com"}
        expect(response).to redirect_to('/users/new')
      end
    end
    context 'user doesnt exist, but is not valid' do
      it 'should redirect to registration page' do
        post :create, :user=>{:user_id=> "nick2",:password=> "firew", :password_confirmation=>"filcrew", :email=>"user@email.com"}
        expect(response).to redirect_to('/users/new')
      end
    end
    it 'should call create! and select the login_path to render' do
      user = double(User)
      allow(user).to receive(:user_id)
      expect(User).to receive(:create!).and_return(user)
      expect(user).to receive(:email).and_return("user@email.com")
      expect(user).to receive(:name).and_return("user@email.com")
      post :create, :user=>{:user_id=> "nick4",:password=> "filmscrew", :password_confirmation=>"filmscrew", :email=>"user@email.com"}
      expect(response).to redirect_to('/login')
    end
  end
  describe 'profile page' do
    before(:each) do
      session[:session_token]='test_token'
    end
    it 'should render the show page' do
      get :show, :id=>1
      expect(response.status).to eq(200)
    end
    it 'should render the login page if not logged in' do
      session[:session_token] = nil
      get :show, :id=>1
      expect(response).to redirect_to('/login')
    end
    context 'provider is facebook' do
      it 'gather friends' do
        user1234 = double(User.omniauth(mock_auth_hash)) 
        expect(user1234.provider).to eq("facebook")
        expect(Koala::Facebook::API).to receive(:new)
        expect(double(Koala::Facebook::API)).to receive(:get_connections)
        get :show, :id=>User.find_by_session_token(user1234.session_token)
      end
    end
  end
  describe 'deleting users' do
    before(:each) do
      session[:session_token]='administrator_token'
    end
    it 'should not allow users to be deleted if user is not admin' do
      user = User.find(1)
      session[:session_token]='test_token'
      expect(User).to_not receive(:find).with('1')
      expect(user).to_not receive(:destroy)
      delete :destroy, :id => 1
      expect(response).to redirect_to('/home')
    end
    it 'should not allow users to be deleted if user is not logged in' do
      user = User.find(1)
      session[:session_token]=nil
      expect(User).to_not receive(:find).with('1')
      expect(user).to_not receive(:destroy)
      delete :destroy, :id => 1
      expect(response).to redirect_to('/home')
    end
    it 'should allow users to be deleted if user is admin' do
      user = User.find(1)
      expect(User).to receive(:find).with('1').and_return(user)
      expect(user).to receive(:destroy).and_return(true)
      delete :destroy, :id => 1
      expect(response).to redirect_to('/users')
    end
    it 'should redirect to admin dashboard if no user is found' do
      user = nil
      expect(User).to receive(:find).with('4').and_return(nil)
      expect(user).to receive(:destroy).and_return(false)
      delete :destroy, :id => 4
      expect(response).to redirect_to('/users')
    end
  end
  describe 'admin dashboard' do
    it 'should not allow user list if not logged in' do
      session[:session_token] = nil 
      expect(User).to_not receive(:all)
      get :index
      expect(response).to redirect_to('/home')
    end
    it 'should not allow user list if not admin' do
      session[:session_token]='test_token'
      get :index
      expect(response).to redirect_to('/home')
    end
    it 'should load user list if logged in as admin' do
      session[:session_token]='administrator_token'
      get :index
      expect(response.status).to eq(200) 
    end
  end
end
