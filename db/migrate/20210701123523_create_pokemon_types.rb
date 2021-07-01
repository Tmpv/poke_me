class CreatePokemonTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_types do |t|
      t.integer :remote_id, index: { unique: true }
      t.string :name

      t.timestamps
    end
  end
end
