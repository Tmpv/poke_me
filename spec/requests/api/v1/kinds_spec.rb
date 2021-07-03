require 'rails_helper'

RSpec.describe 'Api::V1::Kinds', type: :request do
  describe 'GET /index' do
    before(:each) { FactoryBot.create_list :kind, 2 }
    let(:subject) { JSON.parse(response.body).map(&:symbolize_keys) }

    let(:expected_object) do
      Kind.all.map { |k| { name: k.name, id: k.id } }
    end

    it 'returns correct json' do
      get '/api/v1/kinds'
      expect(subject).to eq(expected_object)
    end
  end

  describe 'GET /show' do
    let(:kind) { FactoryBot.create :kind }
    let(:subject) { JSON.parse(response.body).symbolize_keys }
    let(:expected_object) { { id: kind.id, name: kind.name } }

    it 'returns correct json' do
      get "/api/v1/kinds/#{kind.id}"
      expect(subject).to eq(expected_object)
    end
  end
end
