# frozen_string_literal: true

Rails.application.routes.draw do
  match '/404', to: 'errors#not_found', as: :not_found, via: :all
  match '/422', to: 'errors#unprocessable_entity', as: :unprocessable_entity, via: :all
  match '/500', to: 'errors#internal_server_error', as: :internal_server_error, via: :all

  resources :folders do
    resources :bookmarks, only: [:destroy]
    member do
      put :toggle_pin
      delete :destroy_bookmarks
    end

    collection do
      get :search
    end
  end

  authenticated :user do root to: 'folders#index' end
  unauthenticated :user do root to: 'high_voltage/pages#show', id: 'home' end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'
  get '/forbidden', to: 'folders#forbidden', as: 'forbidden'
  
  put '/order_folders_by', to: 'preferences#order_folders_by'
end
