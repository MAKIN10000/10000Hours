class ChangeGoalOwner < ActiveRecord::Migration
  def change
    change_column :goals, :owner, 'integer USING CAST(owner AS integer)'
  end
end
