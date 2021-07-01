FactoryBot.define do
  factory :pokemon do
    sequence(:remote_id)
    sequence(:name) { |n| "pokemon#{n}" }

    height { 40 }
    weight { 70 }
    base_experience { 190 }
  end
end
