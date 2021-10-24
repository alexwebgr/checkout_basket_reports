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

RSpec.describe "/checkout_sessions", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # CheckoutSession. As you add validations to CheckoutSession, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      ended_at: "2021-10-13 15:49:21"
    }
  }

  let(:invalid_attributes) {
    {
      ended_at: nil
    }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CheckoutSessionsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      CheckoutSession.create! valid_attributes
      get checkout_sessions_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      checkout_session = CheckoutSession.create! valid_attributes
      get checkout_session_url(checkout_session), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new CheckoutSession" do
        expect {
          post checkout_sessions_url,
               params: { checkout_session: valid_attributes }, headers: valid_headers, as: :json
        }.to change(CheckoutSession, :count).by(1)
      end

      it "renders a JSON response with the new checkout_session" do
        post checkout_sessions_url,
             params: { checkout_session: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          ended_at: "2021-10-13 15:49:21"
        }
      }

      it "renders a JSON response with the checkout_session" do
        checkout_session = CheckoutSession.create! valid_attributes
        patch checkout_session_url(checkout_session),
              params: { checkout_session: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested checkout_session" do
      checkout_session = CheckoutSession.create! valid_attributes
      expect {
        delete checkout_session_url(checkout_session), headers: valid_headers, as: :json
      }.to change(CheckoutSession, :count).by(-1)
    end
  end
end