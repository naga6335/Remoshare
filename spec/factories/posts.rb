FactoryBot.define do
  factory :post do
    title { 'a' * 30 }
    content { 'a' * 199 }
    issue { 'example' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.sample.png')) }
    review { 3 }
    association :user
  end
end
