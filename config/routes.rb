Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'supports#home'

  namespace :api do
    namespace :v1 do
      namespace :users do
        post :signup, to: 'registrations#create'
        post :verify, to: 'registrations#verify'

        post :login, to: 'sessions#create'

        get 'token/refresh', to: 'tokens#refresh'

        get :me, to: 'profiles#me'
        resources :profiles, only: %i[show]
        put :profiles, to: 'profiles#update'
        patch :profiles, to: 'profiles#update'
        delete :profiles, to: 'profiles#destroy'

        post :forgot_password, to: 'passwords#forgot_password'
        post :reset_password, to: 'passwords#reset_password'
      end
    end
  end
end
