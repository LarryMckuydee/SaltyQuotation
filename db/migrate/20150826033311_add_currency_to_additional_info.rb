class AddCurrencyToAdditionalInfo < ActiveRecord::Migration
  def change
    add_column :additional_infos, :currency, :string
  end
end
