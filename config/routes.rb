# frozen_string_literal: true

Rails.application.routes.draw do
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  resources :folders do
    resources :bookmarks, only: [:destroy]
    member do
      put :toggle_pin
      delete :destroy_bookmarks
    end

    collection do
      get :search
      get :forbidden
    end
  end

  get '/privacy-policy', to: 'pages#privacy_policy'
  get '/terms-of-service', to: 'pages#terms_of_service'

  authenticated :user do root to: 'folders#index' end
  unauthenticated :user do root to: 'pages#home' end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'

  put '/order_folders_by', to: 'preferences#order_folders_by'
end
