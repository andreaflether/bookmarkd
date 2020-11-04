Rails.application.routes.draw do
  resources :tweets
  resources :folders
  resources :bookmarks, only: [:new, :create, :destroy]

  put 'pin_folder/:id', to: 'folders#toggle_folder_pin', as: :toggle_pin 
  
  resources :folders do
    resources :tweets, only: [:destroy]
  end

  get '/privacy-policy', to: 'pages#privacy_policy'
  get '/terms-of-service', to: 'pages#terms_of_service'

  authenticated :user do root to: 'folders#index' end
  unauthenticated :user do root to: 'pages#home' end
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
