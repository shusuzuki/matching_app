FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    qualification { "第一種電気工事士" }
    birth_date { "1996-12-27" }
    sex { "男性" }
  end
end
