require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'

  root 'supports#home'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
    end
  end
end
