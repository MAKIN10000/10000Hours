class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.text :description
      t.string :president_name
      t.string :contact_email
      t.string :charity_website
      t.timestamps
    end
  end
end
