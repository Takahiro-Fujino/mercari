FactoryBot.define do
  factory :address do
    id                    { Faker::Number.number(1).to_s }
    zip_code              { Faker::Number.number(7).to_s }
    prefecture            { Faker::Number.number(2).to_s }
    cuty                  { Faker::Number.number(1).to_s }
    address1              { Faker::Number.number(1).to_s }
    address2              { Faker::Number.number(1).to_s }
    phone_number          { Faker::Number.number(11).to_s }
    user_id               { "1" }
    created_at            { Faker::Date.backward(14).to_s }
    updated_at            { Faker::Date.backward(14).to_s }
  end
end
