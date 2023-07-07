# == Schema Information
#
# Table name: users
#
#  id            :uuid             not null, primary key
#  address       :string           not null
#  birthdate     :date             not null
#  first_name    :string           not null
#  last_name     :string           not null
#  timezone_name :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_birthdate      (birthdate)
#  index_users_on_timezone_name  (timezone_name)
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 90) }
    address { 'New York, NY' }
  end
end
