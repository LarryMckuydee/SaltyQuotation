class CreateConversionRates < ActiveRecord::Migration
  def change
    create_table :conversion_rates do |t|
      t.integer :exchange_rate_cents

      t.timestamps null: false
    end
  end
end
