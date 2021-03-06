require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/checkout_products", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # CheckoutProduct. As you add validations to CheckoutProduct, be sure to
  # adjust the attributes here as well.
  let(:product) { create(:product) }
  let(:checkout_session) { create(:checkout_session) }
  let(:valid_attributes) {
    {
      product_id: product.id,
      checkout_session_id: checkout_session.id
    }
  }

  let(:invalid_attributes) {
    {
      product_id: product.id,
      checkout_session_id: nil
    }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CheckoutProductsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      CheckoutProduct.create! valid_attributes
      get checkout_products_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      checkout_product = CheckoutProduct.create! valid_attributes
      get checkout_product_url(checkout_product), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new CheckoutProduct" do
        expect {
          post checkout_products_url,
               params: { checkout_product: valid_attributes }, headers: valid_headers, as: :json
        }.to change(CheckoutProduct, :count).by(1)
      end

      it "renders a JSON response with the new checkout_product" do
        post checkout_products_url,
             params: { checkout_product: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new CheckoutProduct" do
        expect {
          post checkout_products_url,
               params: { checkout_product: invalid_attributes }, as: :json
        }.to change(CheckoutProduct, :count).by(0)
      end

      it "renders a JSON response with errors for the new checkout_product" do
        post checkout_products_url,
             params: { checkout_product: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          removed_at: "2021-10-13 15:49:21"
        }
      }

      it "updates the requested checkout_product" do
        checkout_product = CheckoutProduct.create! valid_attributes
        patch checkout_product_url(checkout_product),
              params: { checkout_product: new_attributes }, headers: valid_headers, as: :json
        checkout_product.reload
        expect(checkout_product.removed_at).to eq new_attributes[:removed_at]
      end

      it "renders a JSON response with the checkout_product" do
        checkout_product = CheckoutProduct.create! valid_attributes
        patch checkout_product_url(checkout_product),
              params: { checkout_product: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the checkout_product" do
        checkout_product = CheckoutProduct.create! valid_attributes
        patch checkout_product_url(checkout_product),
              params: { checkout_product: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested checkout_product" do
      checkout_product = CheckoutProduct.create! valid_attributes
      expect {
        delete checkout_product_url(checkout_product), headers: valid_headers, as: :json
      }.to change(CheckoutProduct, :count).by(-1)
    end
  end
end
