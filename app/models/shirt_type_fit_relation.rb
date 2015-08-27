class ShirtTypeFitRelation < ActiveRecord::Base
  register_currency :myr
  monetize :price_cents

  belongs_to :shirt_type
  belongs_to :fit
end
