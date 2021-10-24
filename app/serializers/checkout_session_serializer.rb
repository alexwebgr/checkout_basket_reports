class CheckoutSessionSerializer
  def self.to_hash(checkout_session)
    new.to_hash(checkout_session)
  end

  def to_hash(checkout_session)
    {
      token: checkout_session.token,
      started_at: checkout_session.created_at,
      ended_at: checkout_session.ended_at,
      products: []
    }
  end
end
