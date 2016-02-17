class Transaction < ActiveRecord::Base
  attr_readonly :stock, :user, :unit_price, :transaction_type, :quantity
  monetize :unit_price_cents

  belongs_to :stock
  belongs_to :user

  before_validation :stock_info_current

  validates :unit_price, :transaction_type, :quantity, presence: true
  validates :user_can_afford

  private
  def user_can_afford
    if transaction_type == :buy and unit_price * quantity > user.balance
      errors.add(:quantity, "costs more than account contains")
    end
  end

  private
  def stock_info_current
    if Time.now - stock.updated_at > 1.minute
      stock.update_price
    end
    unit_price = stock.last_known_price
  end
end
