class ChangeGoalOwner < ActiveRecord::Migration
  def change
    change_column :goals, :owner, 'integer USING CAST(column_name AS integer)'
  end
end
