Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get 'homes/about' => "homes#about", as: 'about'
  resources :books, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :book_body, only: [:create, :destroy, :update]
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
