class AddColumnToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :totalPledge, :integer
  end
end
