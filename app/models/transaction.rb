class Transaction < ActiveRecord::Base
  attr_readonly :stock, :user, :unit_price, :transaction_type, :quantity
  attr_readonly :updated_at, :created_at
  monetize :unit_price_cents

  belongs_to :stock
  belongs_to :user

  before_validation :stock_info_current

  validates :unit_price, :transaction_type, :quantity, presence: true
  validates :stock, :user, presence: true
  validate :user_can_afford, :has_sufficient_shares


  def buy?
    transaction_type == 1
  end

  def sell?
    transaction_type == -1
  end

  private
  def user_can_afford
    if buy? and unit_price * quantity > user.balance
      errors.add(:quantity, "costs more than account contains")
    end
  end

  private
  def has_sufficient_shares
    if sell?
      shares_owned = Transaction.where(
        user_id: self.user_id, stock_id: self.stock_id).map {|t| 
        t.quantity * t.transaction_type }.inject(&:+)
      errors.add(:quantity, "exceeds shares owned") if quantity > shares_owned
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
