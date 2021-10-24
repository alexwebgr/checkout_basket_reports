class BasketController < ApplicationController
  before_action :set_checkout_session, except: [:remove_product]
  before_action :set_checkout_product, only: [:remove_product]

  # list all products currently in the checkout_products for this session that are not removed
  api :GET, '/basket/list/:checkout_session_id', 'List all products currently in the checkout_products for this session that are not removed'
  param :checkout_session_id, :number, required: true
  error code: 404
  def list
    render json: CheckoutProduct
      .select(:id, :checkout_session_id, :removed_at, :product_id)
      .where(checkout_session: @cs)
      .where(removed_at: nil),
    status: :ok
  end

  # add a product to the checkout_products for this session
  api :POST, '/basket/add_product/:checkout_session_id/:product_id', 'Add a product to the checkout_products for this session'
  param :checkout_session_id, :number, required: true
  param :product_id, :number, required: true
  error code: 403
  error code: 404
  error code: 422
  def add_product
    cp = CheckoutProduct.new(checkout_session: @cs, product_id: params[:product_id])

    if cp.save
      render json: { message: 'Product added' }, status: :created
    else
      render json: cp.errors, status: :unprocessable_entity
    end
  end

  # mark a product as removed by updating the removed_at field in checkout_products table
  api :PATCH, '/basket/remove_product/:checkout_product_id', 'Mark a product as removed by updating the removed_at field in checkout_products table'
  param :checkout_product_id, :number, required: true
  error code: 404
  def remove_product
    @cp.update!(removed_at: Time.current)
    render json: { message: 'product removed' }, status: :ok
  end

  # update the ended_at field in the checkout_session table
  api :PATCH, '/basket/checkout_complete/:checkout_session_id', 'Update the ended_at field in the checkout_session table'
  param :checkout_session_id, :number, required: true
  error code: 404
  def checkout_complete
    @cs.update(ended_at: Time.current)
    render json: { message: 'checkout complete' }, status: :ok
  end

  private

  def set_checkout_product
    @cp = CheckoutProduct.find(params[:checkout_product_id])
  end

  def set_checkout_session
    @cs = CheckoutSession.find(params[:checkout_session_id])
    render json: { message: "completed sessions cannot be modified" }, status: :forbidden unless @cs.ended_at.nil?
  end
end
