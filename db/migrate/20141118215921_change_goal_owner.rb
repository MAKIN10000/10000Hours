class ChangeGoalOwner < ActiveRecord::Migration
  def change
    change_column :goals, :owner, :integer
  end
end
