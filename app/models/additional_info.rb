class AdditionalInfo < ActiveRecord::Base
  if ENV['CURRENCY'] == 'SGD'
    before_save :set_currency_to_sgd!
  else
    before_save :set_currency_to_myr!
  end
  register_currency :myr
  monetize :price_cents,with_model_currency: :currency

  belongs_to :quotation
  belongs_to :apparel_consultant, foreign_key: "approval_id"

  def additional_info_price(quotation_id)
    additional_infos = AdditionalInfo.all.where(quotation_id:quotation_id)
    additional_price = 0
    if additional_infos.any?
      additional_infos.each do |additional_info|
        additional_price = additional_price + additional_info.price_cents
      end
    end
    return additional_price
  end

  def set_currency_to_sgd!
    self.currency = "SGD"
  end

  def set_currency_to_myr!
    self.currency = "MYR"
  end

end
