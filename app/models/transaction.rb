class Transaction < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  attr_readonly :stock, :user, :unit_price, :transaction_type, :quantity
end
