class Goal < ActiveRecord::Base
 attr_accessible :title, :description, :owner, :time, :pledge_amount, :charity
 belongs_to :user
 has_one :charity 
  def self.create_goal! (hash)

    goalHash = {:title => "#{hash[:title]}", :description => "#{hash[:description]}", :owner => "#{hash[:owner]}", :pledge_amount => "#{hash[:pledge_amount]}"}
    
    Goal.create!(goalHash) 
  end


  def time_spent
    return(Time.new - Time.at(self.created_at))
  end
  def percent_time
#returns the percentage as a number between 0 and 100 rather than decimal
    return(time_spent/100.hours)
  end



  def cron_job
    @goal = Goal.all
    @goal.each do |g|
      if g.percent_time == 1
        UserNotifier.send_goal_email(g.user).deliver!
      end
      if g.percent_time == 2
        UserNotifier.send_goal_email(g.user).deliver!
      end
    end
  end

end
