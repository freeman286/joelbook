RailsRealtime::Application.routes.draw do

  root :to => 'home#index'

  match '/search' => 'users#search'
  match '/channel_search' => 'channels#search'
  match '/channel_search_all' => 'channels#search_all'

  match '/read' => 'notifications#read'

  match '/accept/:id' => 'notifications#accept', as: "accept"
  match '/deny/:id' => 'notifications#deny', as: "deny"

  match '/upload' => 'posts#upload'

  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    get "/registrations/crop" => "registrations#crop", as: 'crop_user_registration'
  end
  resources :users do
    member do
      get :images
      get :friends
    end
  end

  match "/users/:id/visable_links" => "users#visible_links"

  resources :user_friendships do
    member do
      put :accept
      post :accept
      put :decline
      post :decline
      put :block
      post :block
      put :unblock
      post :unblock
      post :destroy, as: 'destroy'
    end
  end

  resources :channels, except: :new do
    resources :posts, except: [:new, :show]
  end
  match "/channels/:channel_id/posts/new" => "posts#index"
  match "/channels/:channel_id/add/:id" => "channels#add", as: 'add_channel'
  match "/channels/:channel_id/remove/:id" => "channels#remove", as: 'remove_channel'
  match "/channels/:id/add_private/:user_id" => "channels#add_private", as: 'add_private_channel'
  match "/channels/:channel_id/posts" => "posts#index"
  resources :posts, except: :new

  resources :images
  resources :videos

  resources :notifications

  resources :events


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
