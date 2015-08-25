class Relabel < ActiveRecord::Base
  register_currency :myr
  monetize :relabel_charge_cents

  monetize :converted_relabel_charge_cents

  def converted_relabel_charge_cents
    self.relabel_charge_cents * ConversionRate.last.exchange_rate;
  end
end
