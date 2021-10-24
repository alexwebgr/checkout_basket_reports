require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_one(:checkout_product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:label) }
    it { should validate_presence_of(:price) }
  end
end
