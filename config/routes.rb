Rails.application.routes.draw do 
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

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
