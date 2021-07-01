module PokeApiConsumer
  TYPES_LIMIT = 5
  POKE_LIMIT = 100

  module_function

  def fetch_pokemon_types
    fetch_objects!(type: :type, limit: TYPES_LIMIT)
  end

  def fetch_pokemons
    fetch_objects!(type: :pokemon, limit: POKE_LIMIT)
  end

  def fetch_objects!(type:, limit:)
    total_types_count = PokeApi.get(type).count
    pagination_offset = 0
    results = []

    # Load all of the pokemons is batches, but we gat to fetche them all
    while pagination_offset < total_types_count
      objects = PokeApi.get(type => { offset: pagination_offset, limit: limit }).results
      results.push(*objects)
      pagination_offset += limit
    end

    results
  end
end
