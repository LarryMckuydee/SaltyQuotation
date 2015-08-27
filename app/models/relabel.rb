class Relabel < ActiveRecord::Base
  register_currency :myr
  monetize :relabel_charge_cents
end
