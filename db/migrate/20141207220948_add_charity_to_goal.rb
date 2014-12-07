class AddCharityToGoal < ActiveRecord::Migration
  def change
    add_reference :goals, :charity, index: true
  end
end
