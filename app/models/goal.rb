class Goal < ActiveRecord::Base
 attr_accessible :title, :description, :owner, :time
  belongs_to :user
  def self.create_goal! (hash)

    goalHash = {:title => "#{hash[:title]}", :description => "#{hash[:description]}"}
    
    Goal.create!(goalHash) 
  end
  def time_spent
    return((Time.new - Time.at(self.created_at))/10000.hour)
  end
end
