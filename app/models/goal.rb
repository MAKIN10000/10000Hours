class Goal < ActiveRecord::Base
 attr_accessible :title, :description, :owner, :time

  def self.create_goal! (hash)

    goalHash = {:title => "#{hash[:title]}", :description => "#{hash[:description]}", :owner => "#{hash[:owner]}" }
    
    Goal.create!(goalHash) 
  end
end
