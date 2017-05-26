Rails.application.routes.draw do
  root 'link#new'
  get '/link', to: 'link#new', as: 'login'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :oauth, only: [:new, :create]

  get '/oauth2/callback', to: 'oauth#create'

  get '/examples', to: 'api/main#new', as: 'new_post'
  post '/post', to: 'api/main#create'
  get '/get', to: 'workout#index', as: 'get'
  post '/get', to: 'workout#show'
end
