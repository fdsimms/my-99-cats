Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new] do
    member do
      patch 'approve'
      patch 'deny'
    end
  end

  resources :users, only: [:create, :new]

  resource :session, only: [:new, :create, :destroy]

  root 'cats#index'
end
