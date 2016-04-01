FactoryGirl.define do
  factory :product do
    title {Faker::Name.title}
    price {Faker::Number.decimal(2)}
    published false
    user
  end
end
