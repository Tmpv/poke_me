class RenamePokemonTypesToKinds < ActiveRecord::Migration[6.1]
  def change
    rename_table :pokemon_types, :kinds
  end
end
