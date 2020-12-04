FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    qualification { "第一種電気工事士" }
  end
end
