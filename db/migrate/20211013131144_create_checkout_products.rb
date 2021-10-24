class CreateCheckoutProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkout_products do |t|
      t.timestamp :removed_at
      t.references :product, null: false, foreign_key: true
      t.references :checkout_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
