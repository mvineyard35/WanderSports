Rails.application.routes.draw do
  get "webhooks/stripe"
  devise_for :users

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path
  root 'home#index'

  # Products routes
  get 'products/index'
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member
  end

  # Cart routes
  resource :cart, only: [:show] do
    post 'add', to: 'carts#add'
    delete 'remove/:id', to: 'carts#remove', as: :remove_item
  end

  resources :checkouts, only: [:create, :new] do
    collection do
      patch 'update_item/:id', to: 'checkouts#update_items', as: 'update_items'
      delete 'delete_item/:id', to: 'checkouts#delete_item', as: 'delete_item'
    end
  end

  get 'checkouts/new'

  # Success and cancel pages
  get 'success', to: 'pages#success'
  get 'cancel', to: 'pages#cancel'

  # config/routes.rb
resources :reservations, only: [:new, :create]

resources :waivers, only: [:new, :create]

resources :waivers, only: [] do
  get 'view', on: :collection
end



  # Home routes
  get 'home/index'
  get 'home/admin'
  post 'home/create_special', to: 'home#create_special'
  post 'home/create_inventory', to: 'home#create_inventory'
  post 'home/create_pricing', to: 'home#create_pricing'
  post 'home/create_additional', to: 'home#create_additional'
  post 'home/create_hours', to: 'home#create_hours'
  post 'home/create_image', to: 'home#create_image'
  get 'home/view'
  delete 'home/delete_special/:id', to: 'home#delete_special', as: 'delete_special'
  delete 'home/delete_inventory/:id', to: 'home#delete_inventory', as: 'delete_inventory'
  delete 'home/delete_pricing/:id', to: 'home#delete_pricing', as: 'delete_pricing'
  delete 'home/delete_additional/:id', to: 'home#delete_additional', as: 'delete_additional'
  delete 'home/delete_hour/:id', to: 'home#delete_hour', as: 'delete_hour'
  delete 'home/delete_image/:id', to: 'home#delete_image', as: 'delete_image'
  get 'home/edit/:type/:id', to: 'home#edit', as: 'home_edit'
  patch 'home/update/:type/:id', to: 'home#update', as: 'home_update'
  get 'reservations/reserve'
  get 'home/about'
  get 'home/contact'
  get 'home/policies'
  get 'reservations/view'
  get 'home/gallery'
  get 'waivers/new'
  get 'checkouts/pay'
  get 'waivers/view'
  get 'reservations/past'
  post '/webhooks/stripe', to: 'webhooks#stripe'
end
