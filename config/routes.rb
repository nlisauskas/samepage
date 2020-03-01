Rails.application.routes.draw do
  resources :bids do
    patch :award
    put :award
    resources :comments
  end
  resources :contractors do
    resources :bids
    resources :maintenance_requests
  end
  get 'event/stripe_callback'
  get 'event/payment_profile'

  resources :maintenance_requests do
    resources :bids
    resources :comments
    member do
      patch :resolve
      put :resolve
      patch :contractor_resolve
      put :contractor_resolve
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
      resources :bids
      resources :properties
      resources :tenants
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:new, :create, :destroy]
  resources :comments do
   resources :comments
 end
 resources :payments , only: [:new, :create] do
   get 'bid_award', to: 'payments#bid_award'
 end

  get 'home', to: 'welcome#home'
  post 'payments/webhook', to: 'payments#webhook'
  get 'privacy', to: 'home#privacy'
  get 'terms', to: 'home#terms'
  get 'signup', to: 'users#new', as: 'signup'
  get 'contractor_signup', to: 'contractors#new', as: 'contractor_signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to:'sessions#destroy', as: 'logout'
  get "settings/payment-info/contractors/auth/stripe_connect/callback", to:"contractors#stripe_callback"
  get "settings/payment-info/users/auth/stripe_connect/callback", to:"users#stripe_callback"
end
