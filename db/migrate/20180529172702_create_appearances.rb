class CreateAppearances < ActiveRecord::Migration[5.2]
  def change
    create_table :appearances do |t|
      t.integer :character_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
