Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'cars#index'

  resources :sessions, only: %i[new create] do
    collection { delete :destroy }
  end

  namespace :admin do
    resources :dealerships
    resources :cars
  end
end
