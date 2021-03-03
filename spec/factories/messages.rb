FactoryBot.define do
  factory :message do
    message { 'a' * 200 }
    association :user
    association :room
  end
end
