FactoryBot.define do
  factory :pokemon_type do
    sequence(:remote_id)
    sequence(:name) { |n| "pokemon_type#{n}" }
  end
end
