class AddPledgeToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :pledge_amount, :float
  end
end
