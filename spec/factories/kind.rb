FactoryBot.define do
  factory :kind do
    sequence(:remote_id)
    sequence(:name) { |n| "pokemon_type#{n}" }
  end
end
