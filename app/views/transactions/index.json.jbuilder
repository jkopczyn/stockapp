json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :unit_price, :stock_id, :user_id, :type
  json.url transaction_url(transaction, format: :json)
end
