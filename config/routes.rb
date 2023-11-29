Rails.application.routes.draw do
  get 'product_type_colors/create'
  get 'product_types/colors'
  resources :orders, only: [:index, :create, :destroy, :update]

  get 'main', to: 'pages#main'
  get 'cart', to: 'pages#cart'
  post 'cart', to: 'orders#create'
  get 'mine', to: 'pages#mine'
  get 'manage', to: 'pages#manage'
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

  # resources :product_types, only: [:new, :create, :destroy] do
  # end

  resources :products do
    member do
      post 'new_cart', to: 'products#new_cart', as: 'new_cart'
      # 这里假设你有一个名为 CartsController 的控制器，你可以根据实际情况进行调整
    end
    resource :favorite, only: [:create, :destroy]
    resource :cart_item, only: [:create]
    resources :product_types, only: [:new, :create, :destroy, :update, :edit] do
      member do
        get 'colors', to: 'product_types#colors', as: 'colors'
        get 'sizes', to: 'product_types#sizes', as: 'sizes'
        get 'price', to: 'product_types#price', as: 'price'
      end
      resources :product_type_colors, only: [:create, :destroy]
      resources :product_type_sizes, only: [:create, :destroy]
    end
  end

  resources :favorites, only: [:index]
  delete 'favorites/:id', to: 'favorites#delete', as: 'favorite'

  root "pages#main"

end
