require 'rails_helper'

describe SessionsController do
  describe 'Logging In without facebook' do
    it 'call the model method that performs a search' do
      allow(User).to receive(:nil?).and_return(true)
      expect(User).to receive(:find_by_user_id)
      post :create, :user=>{:user_id=> "nick",:password=> "filmcrew"}
    end
    it 'should set a session variable' do
      post :create, :user=>{:user_id=> "nick", :password=>"filmcrew"}
      expect(session[:session_token]).to_not equal(nil)
    end
  end
  describe 'Logging out' do
    it 'should remove session variable' do
      session[:session_token] = "test_user"
      delete :destroy
      expect(session[:session_token]).to equal(nil)
    end
  end
end

