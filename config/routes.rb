Rails.application.routes.draw do 
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'notifications/index'

  

  devise_for :users
  root 'tracks#index'

  resources :users
  
  resources :tracks do
    member do
      put "like", to: "tracks#upvote"
      put "dislike", to: "tracks#downvote"
    end  
  end

  authenticated :user do
    root  "tracks#profile_track", as: :root_user, via: :get
  end

  post 'tracks/:id/' => 'tracks#destroy', method: :delete, as: 'delete_track'
  
  get 'tracks/:id/profile_track' => 'tracks#profile_track' , as: 'profile_track'

  resources :comments 
  post 'comments/:id/' => 'comments#delete', method: :delete, as: 'delete_comment'

  resources :notifications
  post 'notifications/:id/' => 'notifications#delete', method: :delete, as: 'delete_notification'

  resources :mailboxer

  resources :tags

  get "/messages" => redirect("/conversations")

  resources :messages do
    member do
      post :new
    end
  end

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
    collection do
      get :trashbin
      post :empty_trash
    end
  end

end
