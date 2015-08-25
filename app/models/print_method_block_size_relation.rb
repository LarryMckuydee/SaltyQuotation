class PrintMethodBlockSizeRelation < ActiveRecord::Base
  register_currency :myr
  monetize :price_cents
  monetize :block_charge_price_cents

  monetize :converted_price_cents
  monetize :converted_block_charge_price_cents

  belongs_to :print_method
  belongs_to :block_size

  def converted_price_cents
    self.price_cents * ConversionRate.last.exchange_rate;
  end

  def converted_block_charge_price_cents
    self.block_charge_price_cents * ConversionRate.last.exchange_rate;
  end
end
