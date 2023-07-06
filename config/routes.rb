Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'supports#home'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
    end
  end
end
