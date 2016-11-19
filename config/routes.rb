Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  namespace :admin do
    resources :books
    root 'books#index'
  end

  resources :books, only: [:index, :show]

  resource :cart, only: [:show] do
    put 'add/:book_id', to: 'carts#add', as: :add_to
    put 'remove/:book_id', to: 'carts#remove', as: :remove_from
  end

  resources :orders, only: [:index, :create]

  resources :opinions, only: [:index, :create]

  root 'books#index'
end
