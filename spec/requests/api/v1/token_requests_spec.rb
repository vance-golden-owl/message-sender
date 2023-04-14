require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'token requests', type: :request do
  path '/api/v1/users/token/refresh' do
    get 'Get new access token for user' do
      tags 'Tokens'
      produces 'application/json'
      security [Bearer: {}]

      response '200', 'New access token retrieved' do
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
