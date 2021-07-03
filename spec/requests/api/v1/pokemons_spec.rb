require 'rails_helper'

RSpec.describe 'Api::V1::Pokemons', type: :request do
  describe 'GET /index' do
    before(:each) { FactoryBot.create_list :pokemon, 2, :with_kinds }
    let(:subject) { JSON.parse(response.body).map(&:deep_symbolize_keys) }

    let(:expected_object) do
      Pokemon.includes(:kinds).all.map do |pokemon|
        {
          id: pokemon.id,
          name: pokemon.name,
          kinds: pokemon.kinds.map { |k| { name: k.name } }
        }
      end
    end

    it 'returns correct json' do
      get '/api/v1/pokemons'
      expect(subject).to eq(expected_object)
    end
  end

  describe 'GET /show' do
    let(:pokemon) { FactoryBot.create :pokemon, :with_kinds }
    let(:subject) { JSON.parse(response.body).deep_symbolize_keys }

    let(:expected_object) do
      {
        id: pokemon.id,
        name: pokemon.name,
        remote_id: pokemon.remote_id,
        base_experience: pokemon.base_experience,
        weight: pokemon.weight,
        height: pokemon.height,
        kinds: pokemon.kinds.map { |k| { id: k.id, name: k.name } }
      }
    end

    it 'returns correct json' do
      get "/api/v1/pokemons/#{pokemon.id}"
      expect(subject).to eq(expected_object)
    end
  end
end
