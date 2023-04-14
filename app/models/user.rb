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
class User < ApplicationRecord
  extend Enumerize
  rolify
  has_secure_password

  # constants
  GENDERS = %i[male female transgender gender_neutral non_binary agender pandeger other].freeze

  # attributes
  enumerize :gender, in: GENDERS
  enumerize :nationality_code, in: ISO3166::Country.codes

  # validations
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, on: :create

  def auth_token
    JsonWebToken.encode(user_id: id)
  end

  def nationality
    ISO3166::Country.new(nationality_code)
  end

  def generate_email_verification_token!
    self.email_verification_token = generate_token
    self.email_verification_sent_at = Time.current
    save!
  end

  def email_token_expired?
    (email_verification_sent_at + 4.hours) < Time.current
  end

  def verify_email!
    self.email_verified_at = Time.current
    self.email_verification_token = nil
    save!
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.current
    save!
  end

  def password_token_expired?
    (reset_password_sent_at + 30.minutes) < Time.current
  end

  def reset_password!(new_password)
    self.reset_password_token = nil
    self.password = new_password
    save!
  end

  private

  def generate_token
    (SecureRandom.random_number(9e5) + 1e5).to_i.to_s
  end
end
