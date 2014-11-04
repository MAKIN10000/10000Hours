class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|

      t.timestamps
    end
  end
end
