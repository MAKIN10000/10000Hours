class AddGoalCharityAssociation < ActiveRecord::Migration
  def change
    add_column :goals, :charity_id, :integer
  end
end
