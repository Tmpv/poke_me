class CreatePokemonsKinds < ActiveRecord::Migration[6.1]
  def change
    create_join_table :pokemons, :kinds
  end
end
