class CreateTransactionType < ActiveRecord::Migration
  def up
    execute <<-SQL
          CREATE TYPE transaction_type AS ENUM ('buy', 'sell');
    SQL
  end

  def down
    execute <<-SQL
          DROP TYPE transaction_type;
    SQL
  end
end
