class ProductSerializer
  def self.to_hash(product, cp)
    new.to_hash(product, cp)
  end

  def to_hash(product, cp)
    {
      product_name: product.label,
      product_price: product.price,
      added_at: cp.created_at,
      removed_at: cp.removed_at
    }
  end

  def count_products(product)
    {
      amount_removed: product.amount_removed,
      product_name: product.label,
      product_price: product.price,
    }
  end
end
