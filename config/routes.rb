Rails.application.routes.draw do
  resources :tweets
  resources :folders

  put 'pin_folder/:id', to: 'folders#toggle_folder_pin', as: :toggle_pin 
  
  resources :folders do
    resources :tweets, only: [:destroy]
  end

  authenticated :user do root to: 'folders#index' end
  unauthenticated :user do root to: 'pages#home' end
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
