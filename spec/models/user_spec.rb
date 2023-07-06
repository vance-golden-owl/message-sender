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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
