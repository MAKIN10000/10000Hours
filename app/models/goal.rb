class Goal < ActiveRecord::Base
  attr_accessible :title, :description, :owner, :time
  belongs_to :user
  has_one :charity

  def time_spent
    return(Time.new - Time.at(self.created_at))
  end
  def percent_time
#returns the percentage as a number between 0 and 100 rather than decimal
    return(time_spent/100.hours)
  end
end
