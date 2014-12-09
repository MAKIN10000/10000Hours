require 'rails_helper'

describe GoalsController do
  describe 'Completion' do
    context 'Goal is completed'
    it 'should render index page' do
      expect(Goal).to receive(:find)
      #put :update, :id=>{:user_id => 1, :title=> "HEEEY",:description => "HI", :pledge_amount => 3.5, :charity_id => 3}
      expect(response).to redirect_to('/home')
    end
  end
end

