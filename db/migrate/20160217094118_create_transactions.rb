class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.monetize :unit_price, null: false
      t.references :stock, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end
    add_column :transactions, :type, :transaction_type, null: false
    add_foreign_key :transactions, :stocks
    add_foreign_key :transactions, :users
  end
end
