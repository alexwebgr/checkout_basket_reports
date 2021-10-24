require 'rails_helper'

RSpec.describe "Shops", type: :request do
  describe "GET /list_products" do
    let(:products) { create_list(:product, 2) }

    describe 'when the endpoint is visited' do
      it "list all available products" do
        expected_result = [{
                             "id" => products.first.id,
                             "label" => "MyString",
                             "price" => products.first.price
                           }, {
                             "id" => products.second.id,
                             "label" => "MyString",
                             "price" => products.second.price
                           }]

        get "/shop/list_products"
        expect(response).to have_http_status(:success)
        expect(response.parsed_body).to eq expected_result
      end

      it 'creates a new session' do
        expect {
          get "/shop/list_products"
        }.to change(CheckoutSession, :count).by 1
      end
    end
  end
end
