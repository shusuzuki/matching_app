FactoryBot.define do
  factory :company do
    company_name { "test" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    qualification { "第一種電気工事士" }
  end
end
