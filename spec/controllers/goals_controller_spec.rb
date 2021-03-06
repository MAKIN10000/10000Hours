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

  describe 'Creating a goal that already exists' do
    before(:all) do
      charityID = Charity.where(:title => "testc").id;
    #  charityID = 1;
      goalHash = {:title => "test" , :pledge_amount =>"5", :selected_charity => charityID }
      Goal.create!(goalHash)
      goals_with_that_title = Goal.where(:title => "xxsaeignn__bbnannea842mmr3920wllx69").count
      if (goals_with_that_title > 0)
        Goal.where(:title => "xxsaeignn__bbnannea842mmr3920wllx69").destroy
      end
      charityHash = {:name => "testc", :description => "testc", :president_name => "tester", :contact_email => "test1234567890987654321@test.com", :charity_website => "https://www.test.com" }
      Charity.create!(charityHash)
    end

    it 'should not be created in the database' do
      #charityID = 1;
      charityID = Charity.where(:title => "testc").id;
      goalHash = {:title => "test" , :pledge_amount =>"5", :selected_charity => charityID }
      post :create, :goal => goalHash
      expect(Goal.where(:title => "xxsaeignn__bbnannea842mmr3920wllx69").count).to equal(0)
    end
    after(:all) do
      Goal.where(:title => "xxsaeignn__bbnannea842mmr3920wllx69").destroy
    end

  end

  describe 'Creating a goals that does not already exist' do
    before(:all) do
      goals_with_that_name = Goal.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").count
      if (goals_with_that_name > 0)
        Goal.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").destroy
      end
    end

    it 'should add the goals to the database' do
      #charityID = 1;
      charityID = Charity.where(:title => "testc").id;
      goalHash = {:title => "test" , :pledge_amount =>"5", :selected_charity => charityID }
      post :create, :goal => goalHash

      expect(Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").count).to equal(1)

    end

  end

end





