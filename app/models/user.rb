class User < ActiveRecord::Base
  monetize :balance_cents
  attr_reader :password

  has_many :transactions
  has_many :stocks, -> { distinct }, through: :transactions
  
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  after_initialize :ensure_session_token

  validates :password, length: {minimum: 8, allow_nil: true }
 
  def self.find_by_credentials(email, password)
    cand = self.find_by_email(email)
    if cand and cand.is_password?(password)
      return cand
    else
      return nil
    end
  end

  def stock_profits_hash
    stock_hash = Hash[
    transactions.sort_by {|t| t.stock }.group_by {|t| t.stock}.map do |t_group|
      stock = t_group.first
      ts = t_group.last
      current_price = stock.last_known_price
      total_profit = ts.map do |t| 
        t.quantity * (current_price - t.unit_price) * (t.transaction_type)
      end.inject(&:+)
      total_shares = ts.map {|t| t.quantity * (t.transaction_type) }.inject(&:+)
      [stock, {profit: total_profit, shares: total_shares}]
    end]
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
    session_token
  end

  def password=(plaintext_password)
    self.password_digest = BCrypt::Password.create(plaintext_password)
    @password = plaintext_password
  end

  def is_password?(plaintext_password)
    password_digest.is_password?(plaintext_password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
