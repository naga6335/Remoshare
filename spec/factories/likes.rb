FactoryBot.define do
  factory :like do
    user { post.user }
    association :post
  end
end
