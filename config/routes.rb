Rails.application.routes.draw do
  get '/login', to: 'login#new', as: 'login'
  resources :sessions, only: [:new, :create]
end
