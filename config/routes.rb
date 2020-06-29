Rails.application.routes.draw do
  get 'profile/index'
  get 'home/index'
  root to: 'home#index'
  get 'public/index'
  get 'users/index'
  get 'users/show'
  get 'users/create'
  get 'users/update'
  get 'users/destroy'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/user/:id', to: 'users#show'
  resources :users, only: :show
end
