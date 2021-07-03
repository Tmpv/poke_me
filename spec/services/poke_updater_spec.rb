require 'rails_helper'

describe PokeUpdater do
  describe '.update_kinds_from_remote!' do
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
      expect { described_class.update_kinds_from_remote! }
        .to change(Kind, :count).by(3)
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

  describe '.update_pokemon_kinds!' do
    let(:remote_pokemon_double) do
      instance_double(
        'PokeApi::Pokemon',
        types: [
          instance_double(
            'PokeApi::Pokemon::PokemonType',
            type: instance_double('PokeApi::Type', url: 'some/type/1')
          ),
          instance_double(
            'PokeApi::Pokemon::PokemonType',
            type: instance_double('PokeApi::Type', url: 'some/type/2')
          )
        ]
      )
    end

    let(:pokemon) { FactoryBot.create :pokemon }

    before do
      allow(PokeApi)
        .to receive(:get)
        .and_return(remote_pokemon_double)

      FactoryBot.create :kind, remote_id: 1
      FactoryBot.create :kind, remote_id: 2
    end

    it 'create realation between pokemon and kinds' do
      expect { described_class.update_pokemon_kinds!(pokemon: pokemon) }
        .to change { pokemon.reload.kinds }
    end
  end

  describe '.update_all_pokemon_kinds!' do
    before do
      allow(described_class).to receive(:update_pokemon_kinds!)
      FactoryBot.create_list :pokemon, 2
    end

    it do
      described_class.update_all_pokemon_kinds!
      expect(described_class).to have_received(:update_pokemon_kinds!).twice
    end
  end

  describe '.remote_id_from_url' do
    let(:subject) { PokeUpdater.remote_id_from_url url }

    describe 'for pokemon url' do
      let(:url) { 'https://pokeapi.co/api/v2/pokemon/1/' }

      it { is_expected.to eq('1') }
    end

    describe 'for type url' do
      let(:url) { 'https://pokeapi.co/api/v2/type/1/' }

      it { is_expected.to eq('1') }
    end

    describe 'for empty url' do
      let(:url) { '' }

      it { is_expected.to be_nil }
    end
  end
end
