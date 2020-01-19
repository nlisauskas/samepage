Rails.application.routes.draw do
  resources :maintenance_requests
  get 'welcome/index'
  root 'home#index'

  resources :properties do
    resources :tenants
  end
  resources :tenants
  resources :users do
      resources :properties
      resources :tenants
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:new, :create, :destroy]
  get 'home', to: 'welcome#home'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to:'sessions#destroy', as: 'logout'
end
