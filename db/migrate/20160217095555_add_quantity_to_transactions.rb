class AddQuantityToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :quantity, :integer, null:false
  end
end
