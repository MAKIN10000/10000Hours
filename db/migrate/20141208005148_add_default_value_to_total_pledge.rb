class AddDefaultValueToTotalPledge < ActiveRecord::Migration
  def change
    change_column :charities, :totalPledge, :float, :default => 0.00
  end
end
