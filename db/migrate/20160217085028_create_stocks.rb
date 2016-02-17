class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker_symbol, null: false
      t.monetize :last_known_price, null: false

      t.timestamps null: false
    end
    add_index :stocks, :ticker_symbol, unique: true
  end
end
