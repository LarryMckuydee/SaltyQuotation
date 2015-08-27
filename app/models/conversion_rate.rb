class ConversionRate < ActiveRecord::Base
  register_currency :myr
  monetize :exchange_rate_cents
end
