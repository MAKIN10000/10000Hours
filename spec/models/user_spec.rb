require 'rails_helper'
require 'spec_helper'

describe User do
	describe 'User Model' do
		before :each do
      		@user = [User.new(:user_id => "nmartinson", :email=> 'nick@uiowa.edu', :password => 'filmcrew')]
      		@user1 = {:user_id => "nmartinson", :email=> 'nick@uiowa.edu', :password => 'filmcrew', :password_confirmation => 'filmcrew'}
    end  
		context 'Create user with our website' do
			it 'should create a user in the database' do
				User.create_user!(@user1)
				expect(User.where(:user_id => "#{@user1[:user_id]}").count > 0)
			end
		end
	end
end