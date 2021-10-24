require 'rails_helper'

RSpec.describe CheckoutSession, type: :model do
  describe 'associations' do
    it { should have_many(:checkout_products) }
  end

  describe 'validations' do
    it 'generates a token on creation' do
      checkout_session = CheckoutSession.create

      expect(checkout_session.token).to_not be_nil
    end
  end
end
