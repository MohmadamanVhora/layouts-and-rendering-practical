Rails.application.routes.draw do
  default_url_options :host => "example.com"

  devise_for :users
  
  root "products#index"
  resources :products do
    resources :orders, except: [:index]
  end
  resources :orders, only: :index
  
  resources :employees do
    get "/search", to: "employees#search", on: :collection

  resources :posts, except: :show do
    resources :comments, except: :show
    member do
      get 'like'
      get 'dislike'
    end
  end
end
