FactoryBot.define do
  factory :user do
    id                    { "1" }
    created_at            { "20180202" }
    updated_at            { "20180202" }
    nickname              { "コラッタ" }
    last_name             { "こら" }
    first_name            { "った" }
    last_name_kana        { "コラ" }
    first_name_kana       { "ッタ" }
    date_of_birth         { "19990101" }
    email                 { "kkk@gmail.com" }
    password              { "00000000" }
    password_confirmation { "00000000" }
    provider              { "google" }
    uid                   { "0000000000000000" }
  end
end
