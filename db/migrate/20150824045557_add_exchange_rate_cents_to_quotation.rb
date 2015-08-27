class AddExchangeRateCentsToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :exchange_rate_cents, :integer
  end
end
