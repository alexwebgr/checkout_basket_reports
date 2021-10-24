class ShopController < ApplicationController
  # list all available products and create a new session
  api :GET, '/shop/list_products', 'list all available products and create a new session'
  def list_products
    CheckoutSession.create!

    render json: Product.select(:id, :label, :price).all
  end
end
