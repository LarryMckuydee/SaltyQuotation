class ShirtTypeFitRelation < ActiveRecord::Base
  register_currency :myr
  monetize :price_cents

  monetize :converted_price_cents
  belongs_to :shirt_type
  belongs_to :fit

  def converted_price_cents
    self.price_cents * ConversionRate.last.exchange_rate;
  end
end
