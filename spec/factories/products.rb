FactoryGirl.define do
  factory :product do
    title {Faker::Name.title}
    price {Faker::Number.decimal(2)}
    published false
    quantity 30
    user
  end
end
