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
class UserSerializer < ApplicationSerializer
  fields :email,
         :name,
         :dob,
         :gender,
         :nationality_code,
         :email_verified_at,
         :phone_code,
         :phone_number

  view :auth do
    fields :auth_token
  end
end
