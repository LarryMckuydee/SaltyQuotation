class AddCurrencyToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :currency, :string
  end
end
