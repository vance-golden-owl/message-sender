puts '~> Create users'
10.times do |t|
  FactoryBot.create(:user, email: "user-#{t+1}@gorails.com", password: 'password123')
end
