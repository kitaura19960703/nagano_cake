Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
  }
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    # resources :sessions, only: [:new, :create, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  namespace :public, path:'' do
    root to: 'homes#top'
    get 'about'=> 'homes#about'
    post 'orders/information' => 'orders#information'
    get 'orders/complete' => 'orders#complete'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    # get 'url' => 'controller#action', as: '_path'
    patch 'customers/cancel' => 'customers#cancel'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    # resources :registrations, only: [:new, :create]
    # resources :sessions, only: [:new, :create, :destroy]
    resources :items, only: [:index, :show]
    resources :customers, only: [:edit, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :complete, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    # getやpatchをresourcesの上に持ってくる
  end
end
