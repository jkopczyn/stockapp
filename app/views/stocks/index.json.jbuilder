json.array!(@stocks) do |stock|
  json.extract! stock, :id, :ticker_symbol, :last_known_price
  json.url stock_url(stock, format: :json)
end
