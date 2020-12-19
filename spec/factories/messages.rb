FactoryBot.define do
  factory :message do
    room { nil }
    is_user { false }
    content { "MyText" }
  end
end
