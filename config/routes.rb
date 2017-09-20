Rails.application.routes.draw do
  root 'link#new'
  get '/link', to: 'link#new', as: 'login'

  resources :oauth, only: [:new, :create]
  get '/oauth/deauth', to: 'oauth#deauth'
  get '/oauth2/callback', to: 'oauth#create'

  get '/examples', to: 'api/main#new', as: 'new_post'
  post '/post', to: 'api/main#create'
  get '/get', to: 'api/retrieve#show', as: 'get'
end
