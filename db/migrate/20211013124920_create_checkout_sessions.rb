class CreateCheckoutSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :checkout_sessions do |t|
      t.string :token
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
