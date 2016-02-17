class Stock < ActiveRecord::Base
  attr_readonly :ticker_symbol
  monetize :last_known_price_cents

  has_many :transactions
  has_many :users, through: :transactions

  validates :ticker_symbol, presence: true, uniqueness: true
  validates :last_known_price, presence: true

  def update_price
    Stock.update_prices([self])
    self
  end

  def self.update_prices(stocks)
    client = YahooFinance::Client.new 
    symbols = stocks.map { |stock| stock.ticker_symbol } 
    quotes = Hash[client.quotes(symbols, [:last_trade_price]).map do |options| 
      [options[:symbol], options[:last_trade_price].to_i] 
    end] 
    stocks.each do |stock| 
      stock.update ({ price: quotes[stock.ticker_symbol]}) 
    end 
  end

  def self.find_by_ticker_symbol(symbol)
    cand = super
    return cand if cand
    self.create({ticker_symbol: symbol,  last_known_price: YahooFinance::Client.new.quote(
      symbol.to_s)[:last_trade_price].to_i})
  end
end
