Rails.application.routes.draw do

  root   'posts#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/guest',   to: 'users#guest'

  resources  :users do
    member do
      get :following, :followers
    end
  end

  resources  :posts do
    resources :comments, only: [:create, :destroy]
    resource :likes,     only: [:create, :destroy]
  end

  resources :tags do
    get 'posts', to: 'posts#search'
  end

  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
end
