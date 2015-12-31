Rails.application.routes.draw do
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
 
  get '/', to: 'sessions#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
end

