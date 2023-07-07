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
class User < ApplicationRecord
  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :birthdate, presence: true
  validates :timezone_name, presence: true

  # callbacks
  before_validation :generate_timezone_name, if: :address_changed?

  # scopes
  scope :today_birthday, -> { where('EXTRACT(month FROM birthdate) = ? AND EXTRACT(day FROM birthdate) = ?', Date.current.month, Date.current.day) }

  def generate_timezone_name
    latitude, longitude = Geocoder.search(address).first.coordinates
    self.timezone_name = Timezone.lookup(latitude, longitude)
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
