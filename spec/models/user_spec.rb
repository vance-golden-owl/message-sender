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
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:birthdate) }

  context 'when address attributes is nil' do
    let(:user) { build(:user, address: nil) }

    it 'raise error' do
      user.valid?
      user.errors.full_messages.should include "Address can't be blank"
    end
  end

  context 'when user input address' do
    let!(:user) { create(:user) }

    it 'return correct timezone of address' do
      expect(user.timezone_name).to eq('America/New_York')
    end
  end

  context 'when call method full_name' do
    let!(:user) { create(:user, first_name: 'Vance', last_name: 'Bui') }

    it "return user's full name" do
      expect(user.full_name).to eq('Vance Bui')
    end
  end
end
