Rails.application.routes.draw do
  root 'link#new'
  get '/link', to: 'link#new', as: 'login'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :oauth, only: [:new, :create]

  get '/oauth2/callback', to: 'oauth#create'

  get '/upload', to: 'api/main#new', as: 'new_post'
  post '/upload', to: 'api/main#create'
  get '/retrieve', to: 'workout#index', as: 'retrieve'
  post '/retrieve', to: 'workout#show'
end
