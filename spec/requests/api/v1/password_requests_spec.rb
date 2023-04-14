require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'password requests', type: :request do
  path '/api/v1/users/forgot_password' do
    post "Send reset password code to user's email" do
      tags 'Passwords'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'example@gmail.com' }
        },
        required: ['email']
      }

      response '204', 'Email sent' do
        let!(:user) { create(:user) }
        let(:params) { { email: user.email } }

        run_test!
      end

      response '404', 'Email not exist in database' do
        let(:params) { { email: 'some_random_email@gmail.com' } }

        run_test!
      end
    end
  end

  path '/api/v1/users/reset_password' do
    post 'Reset password according to new input password and code' do
      tags 'Passwords'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          reset: {
            type: :object,
            properties: {
              verification_token: { type: :string, example: '112233', description: '6 character code' },
              new_password: { type: :string, example: 'newpassword123', description: 'Must at least 8 character long' }
            }
          }
        },
        required: ['email', 'new_password']
      }

      response '200', 'Password changed' do
        let!(:user) do
          user = create(:user)
          user.generate_password_token!
          user
        end
        let(:params) { { reset: { verification_token: user.reset_password_token, new_password: 'somenewpassword' } } }

        run_test!
      end
    end
  end
end
