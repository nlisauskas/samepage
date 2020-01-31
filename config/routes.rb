Rails.application.routes.draw do
  resources :contractors do
    resources :maintenance_requests
  end
  get 'event/stripe_callback'
  get 'event/payment_profile'
  resources :maintenance_requests do
    member do
      patch :resolve
      put :resolve
    end
  end
  get 'welcome/index'
  root 'home#index'
  get "settings/payment-info/users/auth/stripe_connect/callback", to:"users#stripe_callback"

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
  get 'contractor_signup', to: 'contractors#new', as: 'contractor_signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to:'sessions#destroy', as: 'logout'
end
