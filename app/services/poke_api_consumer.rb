module PokeApiConsumer
  module_function

  AVAILABLE_TYPES = %i[type pokemon].freeze

  def fetch_objects!(type:, limit:)
    raise ArgumentError unless AVAILABLE_TYPES.include?(type)

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
