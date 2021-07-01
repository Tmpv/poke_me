class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.integer :remote_id, index: { unique: true }
      t.string :name
      t.integer :base_experience
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
