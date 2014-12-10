require 'rails_helper'
require 'spec_helper'

describe User do
	describe 'User Model' do
		before :each do
      		@user = [User.new(:user_id => "nmartinson", :email=> 'nick@uiowa.edu', :password => 'filmcrew')]
      		@user1 = {:user_id => "nmartinson", :email=> 'nick@uiowa.edu', :password => 'filmcrew', :password_confirmation => 'filmcrew'}
          @user3 = User.omniauth(mock_auth_hash)
    end  
		context 'Create user with our website' do
			it 'should create a user in the database' do
				User.create_user!(@user1)
				expect(User.where(:user_id => "#{@user1[:user_id]}").count > 0)
			end
			it 'should not create a duplicate users' do
				User.create_user!(@user1)
				expect(User.where(:user_id => "#{@user1[:user_id]}").count == 1)
			end
		end
    context 'Create User with Facebook' do
      it 'should create a user if it does not exist' do
        @user3.save!
        expect(User.where(:provider => "facebook", :uid => "1234545", :name => "Mock", :token => "mock_token").count > 0)
	    end
      it 'should return the same user if one exists' do
        user = User.omniauth(mock_auth_hash)
        expect(user).to eq(@user3)
	    end
    end
  end
end
