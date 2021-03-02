FactoryBot.define do
  factory :comment do
    association :post
    user { post.user }
    comment { 'a' * 10 }
  end
end
