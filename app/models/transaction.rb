class Transaction < ActiveRecord::Base
  attr_readonly :stock, :user, :unit_price, :transaction_type, :quantity
  monetize :unit_price_cents

  belongs_to :stock
  belongs_to :user

  validates :unit_price, :transaction_type, :quantity, presence: true
end
