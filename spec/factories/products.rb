FactoryBot.define do
  factory :product do
    label { "MyString" }
    price { rand(50..90) }
  end
end
