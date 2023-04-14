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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('me@go.com').for(:email) }
    it { is_expected.not_to allow_value('me.com').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
  end

  describe '#auth_token' do
    let(:user) { build(:user) }

    it 'returns correct jwt token' do
      token = user.auth_token
      object = JsonWebToken.decode(token)
      expect(object.dig(:data, :user_id)).to eq(user.id)
    end
  end
end
