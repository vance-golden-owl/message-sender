puts '~> Create users'
10.times do |t|
  FactoryBot.create(:user, email: "user-#{t+1}@gorails.com", password: 'password123')
end

puts '~> Create shop owners'
10.times do |t|
  user = FactoryBot.create(:user, email: "shop-#{t+1}@gorails.com", password: 'password123')
  user.add_role(:shop_owner)
end