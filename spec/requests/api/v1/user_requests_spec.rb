require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'user requests', type: :request do
  path '/api/v1/users' do
    get 'Retrieve users' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          page: {
            type: :object,
            properties: {
              size: { type: :integer, example: 10 },
              number: { type: :integer, example: 2 }
            }
          }
        }
      }

      response '200', 'Users retrieved' do
        let(:params) {}

        run_test!
      end
    end

    post 'Create user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              first_name: { type: :string, example: 'Vance' },
              last_name: { type: :string, example: 'Bui' },
              birthdate: { type: :integer, example: 1_681_707_699, description: 'Epoch timestamp' },
              address: { type: :string, example: 'Paris' }
            },
            required: ['first_name', 'last_name', 'birthdate', 'address']
          }
        }
      }

      response '200', 'User created' do
        let(:params) { { user: attributes_for(:user) } }

        run_test! do |_res|
          expect(User.count).to eq(1)
        end
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Get info of user based on ID' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', "User's info retrieved" do
        let!(:user) { create(:user) }
        let(:id) { user.id }

        run_test!
      end

      response '404', "User's info not found" do
        let(:id) { 'Invalid' }

        run_test!
      end
    end

    patch "Update user's info based on ID" do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              first_name: { type: :string, example: 'Vance' },
              last_name: { type: :string, example: 'Bui' },
              birthdate: { type: :integer, example: 1_681_707_699, description: 'Epoch timestamp' },
              address: { type: :string, example: 'Paris' }
            }
          }
        }
      }

      response '200', "User's info updated" do
        let!(:user) { create(:user) }
        let(:id) { user.id }
        let(:params) { { user: { first_name: 'Vance' } } }

        run_test! do |_res|
          expect(User.find(id).first_name).to eq('Vance')
        end
      end
    end

    delete 'Remove user base on ID' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'User removed' do
        let!(:user) { create(:user) }
        let(:id) { user.id }

        run_test! do |_res|
          expect(User.count).to eq(0)
        end
      end
    end
  end
end
