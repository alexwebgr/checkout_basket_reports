namespace :importers do
  desc 'create dummy data'
  task :products => :environment do
    cs1 = CheckoutSession.create
    cs2 = CheckoutSession.create
    cs3 = CheckoutSession.create

    10.upto(40) do |price|
      removed_at = nil
      product = Product.create!(label: "product_#{price}", price: price * 10)

      if price > 10 && price < 20
        cs = cs1
        removed_at = Time.current - price.send(:days) if price == 13 || price == 16
      elsif price > 20 && price < 30
        cs = cs2
        removed_at = Time.current - price.send(:days)
      elsif price > 30 && price < 40
        cs = cs3
        removed_at = Time.current - price.send(:days) if price == 34 || price == 37
      end

      CheckoutProduct.create(product: product, checkout_session: cs, removed_at: removed_at)
    end

    cs3.update(ended_at: Time.current)
  end

  desc 'clear dummy data. it will clear all tables'
  task :purge_dummy_data => :environment do
    CheckoutProduct.destroy_all
    CheckoutSession.destroy_all
    Product.destroy_all
  end
end
