class Stock < ActiveRecord::Base
  attr_readonly :ticker_symbol
  monetize :last_known_price_cents

  has_many :transactions
  has_many :users, through: :transactions

  validates :ticker_symbol, presence: true, uniqueness: true
  validates :last_known_price, presence: true
end
