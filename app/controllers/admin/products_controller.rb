class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /admin/products
  api :GET, '/admin/products', 'List products'
  def index
    @products = Product.all

    render json: @products
  end

  # GET /admin/products/1
  api :GET, '/admin/products/:id', 'Show a product'
  def show
    render json: @product
  end

  # POST /admin/products
  api :POST, '/admin/products', 'Create a product'
  error code: 422
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/products/1
  api :PATCH, '/admin/products/:id', 'Update a product'
  error code: 422
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /admin/products/1
  api :DELETE, '/admin/products/:id', 'Destroy a product'
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:label, :price)
    end
end
