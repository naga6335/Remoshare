FactoryBot.define do
  factory :comment do
    association :post
    user { post.user }
    content { 'a' * 100 }
  end
end
