# == Schema Information
#
# Table name: users
#
#  id                         :uuid             not null, primary key
#  apple_uid                  :string
#  dob                        :date
#  email                      :string           default(""), not null
#  email_verification_sent_at :datetime
#  email_verification_token   :string
#  email_verified_at          :datetime
#  gender                     :string
#  google_uid                 :string
#  name                       :string
#  password_digest            :string           default(""), not null
#  phone_code                 :string
#  phone_number               :string
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_apple_uid   (apple_uid)
#  index_users_on_google_uid  (google_uid)
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    name { Faker::Name.first_name }
    gender { User::GENDERS.sample }
    dob { Faker::Date.birthday(min_age: 18, max_age: 90) }
    nationality_code { ISO3166::Country.codes.sample }
    phone_number { Faker::PhoneNumber.cell_phone }
    phone_code { Faker::PhoneNumber.country_code }
    email_verified_at { Faker::Date.between(from: 30.days.ago, to: 1.days.ago) }
  end
end
