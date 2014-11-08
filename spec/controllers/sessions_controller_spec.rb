require 'rails_helper'

describe SessionsController, :type => :controller do
  routes { Tenkhours::Application.routes }
  describe 'Logging In without facebook' do
    it 'call the model method that performs a search' do
      User= double(User)
      allow(User).to receive(:nil?).and_return(true)
      expect(User).to receive(:find_user_by_id)
      post :login_create, :user=>{:user_id=> "kaleb",:password=> "asdfasdf"}, :format=>""
    end
  end
  describe 'Logging out' do
    it 'should remove session variable' do
      delete :logout
    end
  end
end

