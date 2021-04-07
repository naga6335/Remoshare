Rails.application.routes.draw do

  root   'posts#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/guest',   to: 'users#guest'
  get    '/search',  to: 'goods#search'

  resources  :users do
    member do
      get :following, :followers
    end
    get :likes, on: :collection
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource  :likes,    only: [:create, :destroy]
    get :search, on: :collection
  end

  resources :tags do
    get 'posts', to: 'posts#tags'
  end

  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show]
end
