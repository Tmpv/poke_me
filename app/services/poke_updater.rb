module PokeUpdater
  module_function

  TYPES_LIMIT = 5
  POKE_LIMIT = 100

  def update_objects!(type:, limit:, attributes_build_method:, klass:)
    results = PokeApiConsumer.fetch_objects!(type: type, limit: limit)
    normalized = results.map(&method(attributes_build_method))

    # Upsert will update everythin just with one call to the DB
    klass.upsert_all(normalized, { unique_by: %i[remote_id] })
  end

  def update_kinds_from_remote!
    update_objects!(
      type: :type,
      limit: TYPES_LIMIT,
      attributes_build_method: :build_attributes_for_pokemon_type,
      klass: Kind
    )
  end

  def update_pokemons_from_remote!
    update_objects!(
      type: :pokemon,
      limit: POKE_LIMIT,
      attributes_build_method: :build_attributes_for_pokemon,
      klass: Pokemon
    )
  end

  def update_all_pokemon_kinds!
    Pokemon.all.each { |pokemon| update_pokemon_kinds!(pokemon: pokemon) }
  end

  def update_pokemon_kinds!(pokemon:)
    remote_pokemon = PokeApi.get(pokemon: pokemon.remote_id)
    kinds_remote_ids = remote_pokemon
                       .types
                       .map { |t| t&.type&.url }
                       .map(&method(:remote_id_from_url))

    kinds = Kind.where(remote_id: kinds_remote_ids)

    pokemon.kinds = kinds
    pokemon.save
  end

  def build_attributes_for_pokemon_type(element)
    id = remote_id_from_url(element.url)

    { remote_id: id,
      name: element.name,
      created_at: Time.zone.now,
      updated_at: Time.zone.now }
  end

  def build_attributes_for_pokemon(element)
    # We sadly need to fetch each resources sepratly
    element.get

    { remote_id: element.id,
      name: element.name,
      height: element.height,
      weight: element.weight,
      base_experience: element.base_experience,
      created_at: Time.zone.now,
      updated_at: Time.zone.now }
  end

  def remote_id_from_url(url)
    # Withour doing an additional call to the API, we can get the
    # remote_id from an urk attribute provided by the lib
    url.split('/')&.last
  end
end
