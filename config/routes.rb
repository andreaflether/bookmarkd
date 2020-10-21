Rails.application.routes.draw do
  resources :tweets
  resources :folders
  root 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
