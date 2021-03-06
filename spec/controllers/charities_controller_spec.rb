require 'rails_helper'

describe CharitiesController do
  it 'should select the charities page to render' do
      post :create, :charity => {:name => "charity_for_a_test", :description => "test", :president_name => "tester", :contact_email => "testies@test.com", :charity_website => "https://www.test.com" }
      expect(response).to redirect_to('/charities')
  end

  describe 'Creating a charity that already exists' do
    before(:all) do
      movieHash = {:name => "test123", :description => "test", :president_name => "tester", :contact_email => "test1234567890987654321@test.com", :charity_website => "https://www.test.com" }
      Charity.create!(movieHash)
      charities_with_that_name = Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").count
      if (charities_with_that_name > 0)
        Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").destroy
      end
    end

    it 'should not be created in the database' do
      post :create, :charity => {:name => "xxsaeignn__bbnannea842mmr3920wllx69", :description => "test", :president_name => "tester", :contact_email => "test1234567890987654321@test.com", :charity_website => "https://www.test.com" }

      expect(Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").count).to equal(0)
    end
    after(:all) do
      Charity.where(:contact_email => "test1234567890987654321@test.com").destroy
    end

  end

  describe 'Creating a charity that does not already exist' do
    before(:all) do
      charities_with_that_name = Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").count
      if (charities_with_that_name > 0)
        Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").destroy
      end
    end

    it 'should add the charity to the database' do
      post :create, :charity => {:name => "xxsaeignn__bbnannea842mmr3920wllx69", :description => "test", :president_name => "tester", :contact_email => "test12345678909876543210@test.com", :charity_website => "https://www.test.com" }

      expect(Charity.where(:name => "xxsaeignn__bbnannea842mmr3920wllx69").count).to equal(1)

    end

  end

end

