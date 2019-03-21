FactoryBot.define do
  factory :product_image do
    product
    id                     { Faker::Number.number(1).to_s }
    product_id             { Faker::Number.number(1).to_s }
    product_image          { Faker::Avatar.image.to_s }
    created_at             { Faker::Date.backward(14).to_s }
    updated_at             { Faker::Date.backward(14).to_s }
  end
end
