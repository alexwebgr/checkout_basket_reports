require 'rails_helper'

RSpec.describe "Baskets", type: :request do
  let(:checkout_session) { create(:checkout_session) }

  describe "GET /list" do
    describe 'when there is a valid checkout_session_id' do
      let!(:cps) { create_list(:checkout_product, 2, checkout_session: checkout_session) }
      let!(:cp_removed) { create(:checkout_product, checkout_session: checkout_session, removed_at: '2021-10-13 15:49:21') }

      it "returns a list of products that are not removed" do
        get basket_list_url(checkout_session_id: checkout_session.id)

        expect(response).to have_http_status(:success)
        expect(response.parsed_body.count).to eq 2
      end
    end

    describe 'when there is no valid checkout_session_id' do
      it "returns an error message" do
        get basket_list_url(checkout_session_id: 1)
        expect(response).to have_http_status 404
      end
    end
  end

  describe "POST /add_product" do
    let(:product) { create(:product) }

    describe 'when the required params are present' do
      it 'creates a new checkout_product model' do
        expect {
          post basket_add_product_url(checkout_session_id: checkout_session.id, product_id: product.id)
        }.to change(CheckoutProduct, :count).by 1
      end
    end

    describe 'when there are no valid params' do
      it "returns an error message" do
        post basket_add_product_url(checkout_session_id: 1, product_id: 1)
        expect(response).to have_http_status 404
      end
    end

    describe 'when the checkout_session has ended' do
      let!(:cs_ended) { create(:checkout_session, ended_at: '2021-10-13 15:49:21') }

      it "does not add the product" do
        expect {
          post basket_add_product_url(checkout_session_id: cs_ended.id, product_id: product.id)
        }.to change(CheckoutProduct, :count).by 0
        expect(response).to have_http_status 403
        expect(response.parsed_body).to eq({"message"=>"completed sessions cannot be modified"})
      end
    end

    describe 'when the model is invalid because the product does not exist' do
      it "does not add the product" do
        expect {
          post basket_add_product_url(checkout_session_id: checkout_session.id, product_id: 1)
        }.to change(CheckoutProduct, :count).by 0
        expect(response).to have_http_status 422
        expect(response.parsed_body).to eq({"product"=>["must exist"]})
      end
    end
  end

  describe "PATCH /remove_product" do
    describe 'when the required params are present' do
      let(:cp) { create(:checkout_product, checkout_session: checkout_session) }

      it 'marks the product as removed' do
        patch basket_remove_product_url(checkout_product_id: cp.id)
        expect(response).to have_http_status 200
        cp.reload
        expect(cp.removed_at).to_not be_nil
      end
    end

    describe 'when there are no valid params' do
      it "returns an error message" do
        patch basket_remove_product_url(checkout_product_id: 1)
        expect(response).to have_http_status 404
      end
    end
  end

  describe "PATCH /checkout_complete" do
    describe 'when there is a valid checkout_session_id' do
      it "updates the ended_at field in the checkout_session" do
        patch basket_checkout_complete_url(checkout_session_id: checkout_session.id)
        expect(response).to have_http_status 200
      end
    end

    describe 'when there is no valid checkout_session_id' do
      it "returns an error message" do
        patch basket_checkout_complete_url(checkout_session_id: 1)
        expect(response).to have_http_status 404
      end
    end
  end
end
