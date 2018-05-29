class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.integer :actor_id
      t.integer :character_id

      t.timestamps
    end
  end
end
