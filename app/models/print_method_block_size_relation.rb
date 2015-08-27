class PrintMethodBlockSizeRelation < ActiveRecord::Base
  register_currency :myr
  monetize :price_cents
  monetize :block_charge_price_cents
  
  belongs_to :print_method
  belongs_to :block_size

end
