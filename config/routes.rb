Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :orders, only:[:show, :update] do
      resources :order_details, only:[:update]
    end
    get '' => 'orders#index'
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :items, only:[:index, :new, :show, :edit, :create, :update]
  end

  scope module: :customer do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :orders, only:[:new, :show, :index, :create]
    post 'orders/order_confirm'
    get 'orders/complete'
    resources :cart_items, only:[:index, :create, :update, :destroy]
    delete 'cart_items/destroy_all'
    resources :items, only:[:index, :show]
    resources :customers, only:[:show, :edit, :update]
    get 'customers/quit_confirm'
    patch 'customers' => 'customers#quit'
    resources :shipping_addresses, only:[:index, :edit, :create, :update, :destroy]
  end
end
