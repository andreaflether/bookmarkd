Rails.application.routes.draw do
  resources :tweets
  resources :folders

  authenticated :user do root to: 'folders#index' end
  unauthenticated :user do root to: 'pages#home' end
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
