FactoryBot.define do
  factory :pokemon do
    sequence(:remote_id)
    sequence(:name) { |n| "pokemon#{n}" }

    height { 40 }
    weight { 70 }
    base_experience { 190 }

    trait :with_kinds do
      after(:create) do |pokemon|
        create_list :kind, 2, pokemons: [pokemon]
      end
    end
  end
end
