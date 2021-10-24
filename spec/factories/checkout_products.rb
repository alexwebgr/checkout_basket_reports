FactoryBot.define do
  factory :checkout_product do
    removed_at { nil }
    product
    checkout_session
  end
end
