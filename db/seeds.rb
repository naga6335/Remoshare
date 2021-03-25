User.create!(name:  "Test",
             email: "test@example.com",
             password:              "testuser",
             password_confirmation: "testuser",
             admin: true)

32.times do |n|
  name  = "テストユーザー#{n+1}"
  email = "example-#{n+1}@exmaple.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
