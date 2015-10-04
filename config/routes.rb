Rails.application.routes.draw do

  devise_for :users
  root 'topics#index'
  post :incoming, to: 'incoming#create'

  resources :topics do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks do
    resources :likes, only: [:create, :destroy]
  end


end
