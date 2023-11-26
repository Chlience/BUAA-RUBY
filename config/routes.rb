Rails.application.routes.draw do
  resources :orders, only: [:index, :create, :destroy, :update]

  get 'main', to: 'pages#main'
  get 'cart', to: 'pages#cart'
  post 'cart', to: 'orders#create'
  get 'mine', to: 'pages#mine'
  get 'my_orders', to: 'pages#orders'
  get 'my_favorites', to: 'pages#favorites'

  # resource 和 resources 有区别，生成的路径类型不同
  # resource 单数资源路由
  # resources 复数资源路由

  resources :cart_items
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}

  resources :users, only: [:show, :index, :destroy, :edit, :update] do
    resources :cart_items, only: [:index]
  end

  resources :products do
    resource :favorite, only: [:create, :destroy]
    resource :cart_item, only: [:create]
    resources :product_types, only: [:show]
  end

  root "products#index"

  resources :favorites, only: [:index]
  delete 'favorites/:id', to: 'favorites#delete', as: 'favorite'

end
