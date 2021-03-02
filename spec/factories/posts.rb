FactoryBot.define do
  factory :post do
    title { 'a' * 30 }
    content { 'a' * 199 }
    issue { 'example' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.sample.png')) }
    review { 3 }
    user_id { 1 }
    association :user
  end
end
