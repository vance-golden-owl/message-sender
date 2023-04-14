require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'authentications', type: :request do
  path '/api/v1/users/signup' do
    post 'Signup user' do
      tags 'Authentications'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'example@gmail.com' },
              password: { type: :string, example: 'examplepassword' },
              phone_code: { type: :string, example: '84' },
              phone_number: { type: :string, example: '365204546' },
              role: {
                type: :string,
                example: 'shop_owner',
                description: 'Add role for user when create account, for normal user, this parameter is not necesssary. Currently avalaible role: shop_owner'
              }
            },
            required: ['email', 'password']
          }
        }
      }

      response '201', 'Signup successfully' do
        let(:params) { { user: attributes_for(:user).merge(signup_as_shop_owner: false) } }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:params) { { user: attributes_for(:user, password: '').merge(signup_as_shop_owner: false) } }
        run_test!
      end
    end
  end

  path '/api/v1/users/verify' do
    post "Verify user's email" do
      tags 'Authentications'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          verification_token: { type: :string, example: '112233', description: '6 character code' }
        },
        required: ['verification_token']
      }

      response '200', 'Email verified successfully' do
        let!(:user) { create(:user, email_verified_at: nil, email_verification_token: '123456', email_verification_sent_at: Time.current) }
        let(:params) { { verification_token: user.email_verification_token } }

        run_test! do |response|
          response_data = JSON.parse(response.body)
          expect(response_data['email_verified_at']).to be_truthy
        end
      end

      response '404', 'Token invalid' do
        let!(:user) { create(:user, email_verified_at: nil, email_verification_token: '123456', email_verification_sent_at: Time.current) }
        let(:params) { { verification_token: 'invalid_token' } }

        run_test!
      end

      response '401', 'Token expired' do
        let!(:user) { create(:user, email_verified_at: nil, email_verification_token: '123456', email_verification_sent_at: Time.current - 5.hours) }
        let(:params) { { verification_token: user.email_verification_token } }

        run_test!
      end
    end
  end

  path '/api/v1/users/login' do
    post 'Login user' do
      tags 'Authentications'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'user-1@gorails.com' },
              password: { type: :string, example: 'password123' },
              google_uid: { type: :string },
              apple_uid: { type: :string },
              provider: { type: :string, example: 'email', description: 'choose between these 3: email/google/apple' }
            },
            required: ['email']
          }
        }
      }

      response '200', 'Login successfully' do
        let!(:user) { create(:user, password: 'password123') }
        let(:user_params) { { email: user.email, password: 'password123', provider: 'email' } }
        let(:params) { { user: user_params } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:params) { { user: attributes_for(:user, password: '').merge(provider: 'email') } }
        run_test!
      end
    end
  end

  path '/api/v1/users/me' do
    get 'Get profile of user' do
      tags 'Authentications'
      produces 'application/json'
      security [Bearer: {}]

      response '200', 'User profile retrieved successfully' do
        let!(:user) { create(:user, password: 'password123') }
        let(:Authorization) { "Bearer #{user.auth_token}" }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { 'Invalid' }
        run_test!
      end
    end
  end
end
