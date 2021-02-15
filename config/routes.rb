Rails.application.routes.draw do

  root   'post_pages#home'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/guest',   to: 'users#guest'
  resources :users

end
