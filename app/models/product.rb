class Product < ApplicationRecord
  validates :label, presence: true
  validates :price, presence: true

  has_one :checkout_product
end
