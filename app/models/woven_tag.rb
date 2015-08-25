class WovenTag < ActiveRecord::Base
  register_currency :myr
  monetize :tag_charge_cents

  monetize :converted_tag_charge_cents

  def converted_tag_charge_cents
    self.tag_charge_cents * ConversionRate.last.exchange_rate;
  end
end
