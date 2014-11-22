class Goal < ActiveRecord::Base
 attr_accessible :title, :description, :owner, :time
  belongs_to :user
  def time_spent
    return((Time.new - Time.at(self.created_at))/10000.hour)
  end
end
