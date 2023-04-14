require 'rails_helper'

RSpec.describe Auth::LoginUserService, type: :service do
  subject { described_class.new(user_params, strategy) }

  describe '#call for login via email' do
    let(:email) { 'me@go.com' }
    let(:password) { 'password123' }
    let(:provider) { 'email' }
    let(:user_params) { { email: email, password: password, provider: provider } }
    let(:strategy) { Auth::Local.new }

    context 'with correct credentials' do
      let!(:user) { create(:user, email: email, password: password) }

      it 'returns user' do
        user = subject.call
        expect(user).to eq(user)
      end
    end

    context 'with incorrect credentials' do
      it 'raises unauthencated error' do
        expect { subject.call }.to raise_error(APIError::NotAuthenticatedError)
      end
    end
  end

  describe '#call for login with google' do
    let(:email) { 'me@go.com' }
    let(:google_uid) { 'gu123456789' }
    let(:provider) { 'google' }
    let(:user_params) { { email: email, google_uid: google_uid, provider: provider } }
    let(:strategy) { Auth::Google.new }

    context 'user already exist' do
      let!(:user) { create(:user, email: email, password: 'randompass123', google_uid: google_uid) }

      it 'returns user' do
        user = subject.call
        expect(user).to eq(user)
      end
    end

    context 'user not exist' do
      it 'create and return new user' do
        expect(User.find_by(email: email, google_uid: google_uid)).to be_nil
        user = subject.call
        record = User.find_by(email: email, google_uid: google_uid)
        expect(record).not_to be_nil
        expect(user).to eq(record)
      end
    end
  end

  describe '#call for login with apple' do
    let(:email) { 'me@go.com' }
    let(:apple_uid) { 'au123456789' }
    let(:provider) { 'apple' }
    let(:user_params) { { email: email, apple_uid: apple_uid, provider: provider } }
    let(:strategy) { Auth::Apple.new }

    context 'user already exist' do
      let!(:user) { create(:user, email: email, password: 'randompass123', apple_uid: apple_uid) }

      it 'returns user' do
        user = subject.call
        expect(user).to eq(user)
      end
    end

    context 'user not exist' do
      it 'create and return new user' do
        expect(User.find_by(email: email, apple_uid: apple_uid)).to be_nil
        user = subject.call
        record = User.find_by(email: email, apple_uid: apple_uid)
        expect(record).not_to be_nil
        expect(user).to eq(record)
      end
    end
  end
end
