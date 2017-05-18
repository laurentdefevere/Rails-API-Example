Rails.application.routes.draw do
  root 'link#new'
  get '/link', to: 'link#new', as: 'login'
  resources :sessions, only: [:new, :create]
end
