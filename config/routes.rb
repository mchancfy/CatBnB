Rails.application.routes.draw do
  devise_for :users
  root to: "cats#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cats
  get '/dashboard', to: 'cats#dashboard', as: :cats_dashboard

  resources :users
end
