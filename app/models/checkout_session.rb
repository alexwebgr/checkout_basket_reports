class CheckoutSession < ApplicationRecord
  before_validation :create_token, on: :create
  has_many :checkout_products
  has_many :products, through: :checkout_products

  private
  def create_token
    self.token = SecureRandom.urlsafe_base64
  end
end
