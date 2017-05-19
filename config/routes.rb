Rails.application.routes.draw do
  root 'link#new'
  get '/link', to: 'link#new', as: 'login'
  resources :oauth, only: [:new, :create]

  get '/oauth2/callback', to: 'oauth#create'

  get '/upload', to: 'api#new', as: 'new_post'
  post '/upload', to: 'api#create'
end
