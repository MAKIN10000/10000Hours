require 'rails_helper'

describe GoalsController do
  describe 'Completion' do
    before :each do
      @user = User.new(:user_id =>1, :email=> 'nick@gmail', :password => 'filmcrew' )
      @goal = Goal.create(:title => "HEEEY", :description => 'HI', :pledge_amount => 3.5)
    end
    context 'Goal is completed'
    it 'should redirect to index page' do
      #expect(Goal).to receive(:find)
      put :update, :id=>1
      expect(response).to redirect_to('/')
    end
  end
end





