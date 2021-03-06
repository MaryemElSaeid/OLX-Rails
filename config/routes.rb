Rails.application.routes.draw do
  resources :charges
  resources :stores
  resources :categories
  resources :brands
  resources :line_items
  resources :carts
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  root to: "products#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
