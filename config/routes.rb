Rails.application.routes.draw do

  devise_for :users
  #resources :users, only: [:show]
  resources :users, only: [:show]
  root 'topics#index'
  post :incoming, to: 'incoming#create'

  resources :topics do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks do
    resources :likes, only: [:create, :destroy]
  end


end
