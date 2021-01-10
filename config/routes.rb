Rails.application.routes.draw do
  resources :folders do
    put 'pin_folder/:id', on: :collection, to: 'folders#toggle_folder_pin', as: :toggle_pin 
    resources :bookmarks, only: [:destroy]
    get 'search', on: :collection
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
