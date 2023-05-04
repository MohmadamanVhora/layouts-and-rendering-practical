Rails.application.routes.draw do
  default_url_options :host => "example.com"

  devise_for :users
  
  root "products#index"
  resources :products do
    resources :orders, except: [:index]
  end
  resources :orders, only: :index
  # Defines the root path route ("/")
  # root "articles#index"
  root "employees#index"
  resources :employees do
    get "/search", to: "employees#search", on: :collection
  end
end
