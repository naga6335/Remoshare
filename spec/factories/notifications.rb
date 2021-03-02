FactoryBot.define do
  factory :notification do
    action { 'like' }
    association :visitor
    association :visited
    association :post
  end
end
