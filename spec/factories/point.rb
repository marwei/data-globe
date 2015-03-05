FactoryGirl.define do
  factory :point do
    city      { Faker::Address.city }
    state     { Faker::Address.state }
    country   { Faker::Address.country }
    magnitude { Faker::Number.between(1, 100) }
  end
end