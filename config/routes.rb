Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, :like_posts
  end
end
