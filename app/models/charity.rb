class Charity < ActiveRecord::Base
  
  attr_accessible :name, :description, :president_name, :contact_email, :charity_website

  has_many :goals

  def self.create_charity! (hash)

    movieHash = {:name => "#{hash[:name]}", :description => "#{hash[:description]}", :president_name => "#{hash[:president_name]}", :contact_email => "#{hash[:contact_email]}", :charity_website => "#{hash[:charity_website]}" }
    
    Charity.create!(movieHash) 
  end

end
