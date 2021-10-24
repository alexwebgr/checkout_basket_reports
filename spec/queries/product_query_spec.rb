require 'rails_helper'

RSpec.describe ProductQuery, type: :service do
  let(:checkout_session) { create(:checkout_session) }
  let(:checkout_session2) { create(:checkout_session) }

  let(:product_100) { create(:product, price: 100) }
  let(:product_200) { create(:product, price: 200) }
  let(:product_300) { create(:product, price: 300) }
  let(:product_400) { create(:product, price: 400) }

  describe "#count_removed_products" do
    before do
      create(:checkout_product, product: product_200, checkout_session: checkout_session, removed_at: '2021-10-13 12:49:21')
      create(:checkout_product, product: product_300, checkout_session: checkout_session)
      create(:checkout_product, product: product_400, checkout_session: checkout_session, removed_at: '2021-10-13 15:49:21')
      create(:checkout_product, product: product_400, checkout_session: checkout_session, removed_at: '2021-10-13 15:49:21')

      create(:checkout_product, product: product_100, checkout_session: checkout_session2, removed_at: '2021-10-13 13:49:21')
      create(:checkout_product, product: product_200, checkout_session: checkout_session2)
      create(:checkout_product, product: product_300, checkout_session: checkout_session2)
    end

    describe 'when there are 6 checkout products and 3 have been marked as removed' do
      it "3 are returned sorted by most expensive" do
        products = described_class.new.count_removed_products
        expected_result = JSON.parse(file_fixture('count_products.json').read)

        expect(products.count).to eq 3
        expect(products.as_json).to eq expected_result
        expect(products[0][:product_price]).to eq 400.0
      end
    end
  end

  describe "#products_grouped_by_session" do
    before do
      create(:checkout_product, product: product_200, checkout_session: checkout_session, removed_at: '2021-10-13 12:49:21')
      create(:checkout_product, product: product_300, checkout_session: checkout_session)
      create(:checkout_product, product: product_400, checkout_session: checkout_session, removed_at: '2021-10-13 15:49:21')

      create(:checkout_product, product: product_100, checkout_session: checkout_session2, removed_at: '2021-10-13 13:49:21')
      create(:checkout_product, product: product_200, checkout_session: checkout_session2)
      create(:checkout_product, product: product_300, checkout_session: checkout_session2)
    end

    describe 'when the removed_status is missing' do
      it "returns all of them" do
        products = described_class.new.products_grouped_by_session
        expect(products[checkout_session.token][:products].count).to eq 3
        expect(products[checkout_session2.token][:products].count).to eq 3
      end
    end

    describe 'when the removed_status = all' do
      it "returns all of them" do
        products = described_class.new.products_grouped_by_session('all')
        expect(products[checkout_session.token][:products].count).to eq 3
        expect(products[checkout_session2.token][:products].count).to eq 3
      end
    end

    describe 'when the removed_status = removed' do
      it "returns only the removed ones" do
        products = described_class.new.products_grouped_by_session('removed')
        expect(products[checkout_session.token][:products].count).to eq 2
        expect(products[checkout_session2.token][:products].count).to eq 1
      end
    end

    describe 'when the removed_status = not_removed' do
      it "returns all except the removed ones" do
        products = described_class.new.products_grouped_by_session('not_removed')
        expect(products[checkout_session.token][:products].count).to eq 1
        expect(products[checkout_session2.token][:products].count).to eq 2
      end
    end
  end

  describe "#products" do
    describe 'when there are 6 checkout products and 4 have been marked as removed' do
      before do
        create_list(:checkout_product, 2, checkout_session: checkout_session)
        create(:checkout_product, product: product_100, checkout_session: checkout_session, removed_at: '2021-10-13 12:49:21')
        create(:checkout_product, product: product_200, checkout_session: checkout_session)
        create(:checkout_product, product: product_300, checkout_session: checkout_session, removed_at: '2021-10-13 14:49:21')
        create(:checkout_product, product: product_400, checkout_session: checkout_session, removed_at: '2021-10-13 15:49:21')
      end

      describe 'when the removed_status is missing' do
        it "returns all of them" do
          products = described_class.new.products
          expect(products.count).to eq 6
          expect(products[0][:product_price]).to eq 400.0
        end
      end

      describe 'when the removed_status = all' do
        it "returns all of them" do
          products = described_class.new.products('all')
          expect(products.count).to eq 6
          expect(products[0][:product_price]).to eq 400.0
        end
      end

      describe 'when the removed_status = removed' do
        it "returns only the removed ones" do
          products = described_class.new.products('removed')
          expect(products.count).to eq 3
          expect(products[0][:product_price]).to eq 400.0
        end
      end

      describe 'when the removed_status = not_removed' do
        it "returns all except the removed ones" do
          products = described_class.new.products('not_removed')
          expect(products.count).to eq 3
          expect(products[0][:product_price]).to eq 200.0
        end
      end
    end
  end
end
