class Admin::CheckoutSessionsController < ApplicationController
  before_action :set_checkout_session, only: [:show, :update, :destroy]

  # GET /admin/checkout_sessions
  api :GET, '/admin/checkout_sessions', 'List checkout sessions'
  def index
    @checkout_sessions = CheckoutSession.all

    render json: @checkout_sessions
  end

  # GET /admin/checkout_sessions/1
  api :GET, '/admin/checkout_sessions/:id', 'Show a checkout session'
  def show
    render json: @checkout_session
  end

  # POST /admin/checkout_sessions
  api :POST, '/admin/checkout_sessions', 'Create a checkout session'
  def create
    @checkout_session = CheckoutSession.create!
    render json: @checkout_session, status: :created, location: @checkout_session
  end

  # PATCH/PUT /admin/checkout_sessions/1
  api :PATCH, '/admin/checkout_sessions/:id', 'Update a checkout session'
  api :PUT, '/admin/checkout_sessions/:id', 'Update a checkout session'
  def update
    @checkout_session.update!(checkout_session_params)
    render json: @checkout_session
  end

  # DELETE /admin/checkout_sessions/1
  api :DELETE, '/admin/checkout_sessions/:id', 'Destroy a checkout session'
  def destroy
    @checkout_session.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout_session
      @checkout_session = CheckoutSession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checkout_session_params
      params.require(:checkout_session).permit(:ended_at)
    end
end
