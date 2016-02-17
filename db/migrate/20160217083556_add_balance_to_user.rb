class AddBalanceToUser < ActiveRecord::Migration
  def change
    add_monetize :users, :balance
  end
end
