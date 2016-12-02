Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  namespace :admin do
    resources :books do
      get 'stats', on: :collection
    end
    root 'books#index'
  end

  resources :users, only: [:show]

  resources :books, only: [:index, :show, :update]

  resources :carts

  resources :orders, only: [:index, :create]

  resources :opinions, only: [:index, :create]

  resources :ratings, only: [:index, :create]

  root 'books#index'
end
