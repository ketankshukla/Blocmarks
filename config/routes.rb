Rails.application.routes.draw do


  devise_for :users
  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:create, :destroy]
    end
  end



  #root 'home#index'
  root 'topics#index'
  post :incoming, to: 'incoming#create'

end
