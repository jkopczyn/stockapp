class Stock < ActiveRecord::Base
  attr_readonly :ticker_symbol
end
