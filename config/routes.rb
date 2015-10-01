Rails.application.routes.draw do
  #get 'incoming/create'

  #get 'users/show'

  devise_for :users
  resources :topics do
    resources :bookmarks, only: [:edit, :show, :create, :update, :destroy]
  end

  #root 'home#index'
  root 'topics#index'
  post :incoming, to: 'incoming#create'

end
