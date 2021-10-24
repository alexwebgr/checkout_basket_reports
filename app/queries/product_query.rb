class ProductQuery
  private

  def count_products
    <<-SQL
      SELECT
        COUNT(prod.label) AS amount_removed,
        prod.label AS label,
        prod.price AS price
      FROM checkout_products
        INNER JOIN products prod
          ON prod.id = checkout_products.product_id
      WHERE removed_at IS NOT NULL
      GROUP BY prod.label, prod.price
      ORDER BY prod.price DESC
    SQL
  end

  def all_checkout_products
    CheckoutProduct
      .includes(:product)
      .includes(:checkout_session)
      .order("products.price DESC")
  end

  def removed_checkout_products
    all_checkout_products.where.not(removed_at: nil)
  end

  def not_removed_checkout_products
    all_checkout_products.where(removed_at: nil)
  end

  def checkout_products(removed_status)
    removed_status = 'all' if removed_status.nil?
    send("#{removed_status}_checkout_products")
  end

  public

  def count_removed_products
    CheckoutProduct.find_by_sql(count_products).map { |product| ProductSerializer.new.count_products(product) }
  end

  def products_grouped_by_session(removed_status = nil)
    checkout_products(removed_status).each_with_object({}) do |cp, memo|
      if memo[cp.checkout_session.token].nil?
        memo[cp.checkout_session.token] = CheckoutSessionSerializer.to_hash(cp.checkout_session)
      end
      memo[cp.checkout_session.token][:products] << ProductSerializer.to_hash(cp.product, cp)
    end
  end

  def products(removed_status = nil)
    checkout_products(removed_status).map { |cp| ProductSerializer.to_hash(cp.product, cp) }
  end
end
