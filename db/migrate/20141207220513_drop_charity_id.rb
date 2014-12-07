class DropCharityId < ActiveRecord::Migration
  def change
    remove_column :goals, :charity_id
  end
end
