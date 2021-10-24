require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /count_removed_products" do
    it "returns http success" do
      get "/reports/count_removed_products"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /products_grouped_by_session" do
    it "returns http success" do
      get "/reports/products_grouped_by_session"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /products" do
    it "returns http success" do
      get "/reports/products"
      expect(response).to have_http_status(:success)
    end
  end
end
