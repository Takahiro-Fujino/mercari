FactoryBot.define do
  factory :credit do
    id                    { Faker::Number.number(1).to_s }
    token                 { Faker::Number.number(16).to_s }
    user_id               { Faker::Number.number(1).to_s }
    created_at            { Faker::Date.backward(14).to_s }
    updated_at            { Faker::Date.backward(14).to_s }
  end
end
