Rails.application.routes.draw do
  root to:'homes#top'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end

  get "home/about" => "homes#about"
end
