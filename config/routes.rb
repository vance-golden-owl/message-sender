Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'supports#home'

  namespace :api do
    namespace :v1 do
    end
  end
end
