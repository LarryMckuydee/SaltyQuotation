class WovenTag < ActiveRecord::Base
  register_currency :myr
  monetize :tag_charge_cents
end
