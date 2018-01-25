Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  resources :posts do
    resources :comments, :like_posts
  end
  resources :users, only: [:show, :edit, :update]
  resources :friendships, only: [:create, :update, :destroy]
end
