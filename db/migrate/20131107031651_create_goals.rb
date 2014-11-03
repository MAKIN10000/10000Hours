class CreateMovies < ActiveRecord::Migration
  def up
    create_table 'goals' do |t|
      t.string 'name'
      t.text 'description'
      t.datetime 'start_date'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_tabe 'movies' # deletes the whole table and all its data!
  end
end
