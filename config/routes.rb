Rails.application.routes.draw do

  root 'post_pages#home'
  get '/signup', to: 'users#new'

end
