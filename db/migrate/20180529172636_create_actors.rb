class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.string :name
      t.string :bio
      t.string :img
      t.integer :ext_actor_id

      t.timestamps
    end
  end
end
