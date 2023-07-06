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
class UserSerializer < ApplicationSerializer
  fields :first_name,
         :last_name,
         :address,
         :timezone_name

  field :birthdate do |user|
    user.birthdate&.to_time.to_i
  end
end
