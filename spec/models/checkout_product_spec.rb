require 'rails_helper'

RSpec.describe CheckoutProduct, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:checkout_session) }
  end

  describe 'validations' do
  end
end
