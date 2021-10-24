class ReportsController < ApplicationController
  # count how many times a product was removed from the basket (checkout_products)
  api :GET, '/reports/count_removed_products', 'Count how many times a product was removed from the basket (checkout_products)'
  def count_removed_products
    render json: ProductQuery.new.count_removed_products, status: :ok
  end

  # show me all sessions with a list of products
  api :GET, '/reports/products_grouped_by_session', 'Show me all sessions with a list of products'
  param :removed_status, String, default_value: 'all'
  def products_grouped_by_session
    render json: ProductQuery.new.products_grouped_by_session(params[:removed_status]), status: :ok
  end

  # show me a list of removed products sorted by most expensive
  api :GET, '/reports/products', 'Show me a list of removed products sorted by most expensive'
  param :removed_status, String, default_value: 'all'
  def products
    render json: ProductQuery.new.products(params[:removed_status]), status: :ok
  end
end
