FactoryBot.define do
  factory :product do
    id                     { "1" }
    name                   { "モンベル スペリオダウンジャケット" }
    product_description    { "保温性と軽量性を高次元で両立したジャケット" }
    category1              { "メンズ" }
    category2              { "ジャケット/アウター" }
    category3              { "ダウンジャケット" }
    brand                  { "モンベル" }
    size                   { "XL" }
    condition              { "未使用に近い" }
    postage                { "送料込み(出品者負担)" }
    shipping_method        { "未定" }
    ship_from              { "福岡県" }
    shipping_date          { "1~2日で発送" }
    price                  { Faker::Number.number(4).to_s }
    point                  { Faker::Number.number(2).to_s }
    image                  { Faker::Avatar.image.to_s }
    sales_condition        { Faker::Number.number(1).to_s }
    user_id                { "1}" }
    created_at             { Faker::Date.backward(14).to_s }
    updated_at             { Faker::Date.backward(14).to_s }
  end
end
