Rails.application.routes.draw do
  resources :users

  resources :posts do
    resources :comments
  end

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]

  get 'static/about'
  get 'static/constitution'
  get '/', to: 'posts#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/posts/:id/favorite', to: 'posts#upvote'
end
