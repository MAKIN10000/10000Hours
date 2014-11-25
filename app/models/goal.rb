class Goal < ActiveRecord::Base
 attr_accessible :title, :description, :owner, :time, :pledge_amount

  def self.create_goal! (hash)

    goalHash = {:title => "#{hash[:title]}", :description => "#{hash[:description]}", :owner => "#{hash[:owner]}", :pledge_amount => "#{hash[:pledge_amount]}"}
    
    Goal.create!(goalHash) 
  end
  def time_spent
    return((Time.new - Time.at(self.created_at))/10000.hour)
  end
end
