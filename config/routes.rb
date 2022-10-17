Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   namespace :admin do
    get '/' => 'homes#top'
    resources :items
    resources :homes
    resources :customers
    resources :genres
    resources :order_details
    resources :orders
  end
  
   namespace :public do
     resources :cart_items
     resources :customers
     resources :homes
     resources :orders
     resources :sipping_addresses
   end
   
root to: "public/homes#top"
  
end
