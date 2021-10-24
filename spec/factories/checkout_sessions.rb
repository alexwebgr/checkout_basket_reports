FactoryBot.define do
  factory :checkout_session do
    token { "MyString" }
    ended_at { nil }
  end
end
