require 'rails_helper'

describe PokeUpdater do
  describe '.update_pokemon_types_from_remote!' do
    let(:pokemon_type_objects) do
      [
        instance_double('PokeApi::Type', url: 'type/1/', name: 'Type 1'),
        instance_double('PokeApi::Type', url: 'type/2/', name: 'Type 2'),
        instance_double('PokeApi::Type', url: 'type/3/', name: 'Type 3')
      ]
    end

    before(:each) do
      allow(PokeApiConsumer)
        .to receive(:fetch_objects!)
        .and_return(pokemon_type_objects)
    end

    it do
      expect { described_class.update_pokemon_types_from_remote! }
        .to change(PokemonType, :count).by(3)
    end
  end

  describe '.update_pokemons_from_remote!' do
    let(:base_attributes) do
      { height: 70,
        weight: 40,
        base_experience: 180,
        get: -> {} }
    end

    let(:pokemon_objects) do
      [
        instance_double('PokeApi::Pokemon', id: 1, name: 'bulbasaur', **base_attributes),
        instance_double('PokeApi::Pokemon', id: 2, name: 'charmander', **base_attributes),
        instance_double('PokeApi::Pokemon', id: 3, name: 'squirtle', **base_attributes)
      ]
    end

    before(:each) do
      allow(PokeApiConsumer)
        .to receive(:fetch_objects!)
        .and_return(pokemon_objects)
    end

    it do
      expect { described_class.update_pokemons_from_remote! }
        .to change(Pokemon, :count).by(3)
    end
  end
end
