class CheckoutProductsController < ApplicationController
  before_action :set_checkout_product, only: [:show, :update, :destroy]

  # GET /checkout_products
  api :GET, '/checkout_products', 'List checkout products'
  def index
    @checkout_products = CheckoutProduct.all

    render json: @checkout_products
  end

  # GET /checkout_products/1
  api :GET, '/checkout_products/:id', 'Show a checkout product'
  def show
    render json: @checkout_product
  end

  # POST /checkout_products
  api :POST, '/checkout_products', 'Create a checkout product'
  error code: 422
  def create
    @checkout_product = CheckoutProduct.new(checkout_product_params)

    if @checkout_product.save
      render json: @checkout_product, status: :created, location: @checkout_product
    else
      render json: @checkout_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /checkout_products/1
  api :PATCH, '/checkout_products/:id', 'Update a checkout product'
  error code: 422
  def update
    if @checkout_product.update(checkout_product_params)
      render json: @checkout_product
    else
      render json: @checkout_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /checkout_products/1
  api :DELETE, '/checkout_products/:id', 'Destroy a checkout product'
  def destroy
    @checkout_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout_product
      @checkout_product = CheckoutProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checkout_product_params
      params.require(:checkout_product).permit(:removed_at, :product_id, :checkout_session_id)
    end
end
