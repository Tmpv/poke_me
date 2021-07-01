require 'rails_helper'

describe PokeApiConsumer do
  describe '.fetch_objects!' do
    before(:each) { allow(PokeApi).to receive(:get).and_return(poke_api_list_double) }

    let(:poke_api_type) { instance_double('PokeApi::Type', name: 'Sparta') }
    let(:poke_api_results_list) { Array.new(5, poke_api_type) }

    let(:poke_api_list_double) do
      instance_double(
        'PokeApi::ApiResourceList',
        count: 10,
        results: poke_api_results_list
      )
    end

    describe 'with valid `type`' do
      it 'should return the right count of elements' do
        expect(described_class.fetch_objects!(type: :type, limit: 5).count)
          .to eq(10)
      end

      it 'should have a pokemon named `Sparta`' do
        expect(described_class.fetch_objects!(type: :type, limit: 5).first.name)
          .to eq('Sparta')
      end

      it 'not to raise argument error' do
        expect { described_class.fetch_objects!(type: :type, limit: 5) }
          .not_to raise_error(ArgumentError)
      end
    end

    describe 'with invalid `type`' do
      it 'to raise argument' do
        expect { described_class.fetch_objects!(type: :sparta, limit: 5) }
          .to raise_error(ArgumentError)
      end
    end
  end
end
