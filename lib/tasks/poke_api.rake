namespace :poke_api do
  desc 'Pull data from PokeApi'

  task update_all: :environment do
    puts 'Pulling types...'
    PokeUpdater.update_kinds_from_remote!

    puts 'Catching all of the POKEMON.....'
    PokeUpdater.update_pokemons_from_remote!

    puts 'Updating pokemon to kind relation'
    PokeUpdater.update_all_pokemon_kinds!
  end
end
