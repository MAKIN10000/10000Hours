class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
<<<<<<< HEAD
      t.string :owner
=======
>>>>>>> master
      t.timestamps
    end
  end
end
