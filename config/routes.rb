Rails.application.routes.draw do
  apipie
  get 'reports/count_removed_products'
  get 'reports/products_grouped_by_session'
  get 'reports/products'

  get 'basket/list/:checkout_session_id', to: 'basket#list', as: 'basket_list'
  post 'basket/add_product/:checkout_session_id/:product_id', to: 'basket#add_product', as: 'basket_add_product'
  patch 'basket/remove_product/:checkout_product_id', to: 'basket#remove_product', as: 'basket_remove_product'
  patch 'basket/checkout_complete/:checkout_session_id', to: 'basket#checkout_complete', as: 'basket_checkout_complete'

  get 'shop/list_products'

  resources :checkout_products
  resources :checkout_sessions
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
