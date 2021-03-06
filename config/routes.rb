Rails.application.routes.draw do
  devise_for :customer, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'search'=> 'searches#search'
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
    post 'orders/order_confirm'
    get 'orders/complete'
    delete 'cart_items/all_destroy'
    get 'customers/quit_confirm'
    patch 'customers/quit'
    get 'search'=> 'searches#search'
    resources :orders, only:[:new, :show, :index, :create]
    resources :cart_items, only:[:index, :create, :update, :destroy]
    resources :items, only:[:index, :show]
    resource :customers, only:[:show, :edit, :update]
    resources :shipping_addresses, only:[:index, :edit, :create, :update, :destroy]
  end
end