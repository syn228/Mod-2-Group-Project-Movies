class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :genre
      t.string :budget
      t.string :producer
      t.string :img
      t.integer :api_movie_id


      t.timestamps
    end
  end
end
