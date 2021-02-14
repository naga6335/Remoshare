# # ユーザー作成
# 1.upto(39) do |i|
#   name  = Faker::Name.name
#   email = "sample-#{i}@example.com"
#   password = 'password'
#   User.create!(name: name,
#                 email: email,
#                 password: password,
#                 password_confirmation: password)
# end

# users = User.order(:created_at).take(6)
# 30.times do
#   content = Faker::Lorem.sentence(word_count: 5)
#   users.each { |user| user.posts.create!(content: content) }
# end
