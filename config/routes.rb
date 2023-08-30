Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get 'homes/about' => "homes#about", as: 'about'
  resources :books, only: [:new, :index,:show,:edit,:create,:destroy,:update]
  resources :book_body, only: [:create, :destroy, :update]
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
