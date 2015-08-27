class Quotation < ActiveRecord::Base

  validates :customer, presence: true
  validates :quantity, presence: true
  validates :shirt_type,presence: true
  validates :fit,presence: true
  validates :front_block_no,presence: true,numericality:{less_than:11}
  validates :back_block_no,presence: true,numericality:{less_than:11}
  validates :left_block_no,presence: true,numericality:{less_than:11}
  validates :right_block_no,presence: true,numericality:{less_than:11}
  validates :special_print,presence: true,numericality:{less_than:3,only_integer:true}
  validates :sew_tag_charge_cents,numericality:{only_integer:true}


  if ENV['CURRENCY'] == 'SGD'
    before_save :set_currency_to_sgd!,:store_exchange_rate
  else
    before_save :set_currency_to_myr!
  end

  register_currency :myr
  monetize :budget_cents,with_model_currency: :currency
  monetize :rush_fee_cents,with_model_currency: :currency
  monetize :delivery_fee_cents,with_model_currency: :currency
  monetize :price_cents,with_model_currency: :currency
  monetize :cost_cents,with_model_currency: :currency
  monetize :min_rrp_cents,with_model_currency: :currency
  monetize :max_rrp_cents,with_model_currency: :currency
  monetize :actual_price_cents,with_model_currency: :currency
  monetize :total_cost_cents,with_model_currency: :currency
  monetize :sew_tag_charge_cents,with_model_currency: :currency
  monetize :woven_tag_charge_cents,with_model_currency: :currency
  monetize :relabel_charge_cents,with_model_currency: :currency
  monetize :exchange_rate_cents,:allow_nil => true


  belongs_to :customer
  # belongs_to :design
  belongs_to :shirt_type
  belongs_to :brand
  belongs_to :fit
  # belongs_to :printing_detail, foreign_key: "printing_id"
  # has_one :front_print, class_name: "Print", foreign_key: "front_print_id"
  # has_one :back_print, class_name: "Print", foreign_key: "back_print_id"
  # has_one :left_print, class_name: "Print", foreign_key: "left_print_id"
  # has_one :right_print, class_name: "Print", foreign_key: "right_print_id"

  belongs_to :front_print_method, foreign_key: "front_print_method_id",class_name:"PrintMethod"
  belongs_to :front_block_size,foreign_key: "front_block_size_id",class_name:"BlockSize"
  # belongs_to :block_no,foreign_key: "front_block_no_id"

  belongs_to :back_print_method, foreign_key: "back_print_method_id",class_name:"PrintMethod"
  belongs_to :back_block_size,foreign_key: "back_block_size_id",class_name:"BlockSize"
  # belongs_to :block_no,foreign_key: "back_block_no_id"

  belongs_to :left_print_method, foreign_key: "left_print_method_id",class_name:"PrintMethod"
  # belongs_to :block_no,foreign_key: "left_block_no_id"

  belongs_to :right_print_method, foreign_key: "right_print_method_id",class_name:"PrintMethod"
  # belongs_to :block_no,foreign_key: "right_block_no_id"

  belongs_to :apparel_consultant, foreign_key: "ac_id"

  belongs_to :approver, foreign_key: "approval_id",class_name:"ApparelConsultant"

  # belongs_to :costing
  # belongs_to :negotiation
  has_many :additional_infos

  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :shirt_type
  accepts_nested_attributes_for :fit
  accepts_nested_attributes_for :additional_infos
  accepts_nested_attributes_for :customer
  def showprice(shirtid,fitid,methodid,sizeid,quantity,noblock)
    @shirtprice = ShirtType.all.find(shirtid).shirt_type_fit_relations.where("fit_id = ? AND ?<= end_quantity AND ?>=start_quantity",fitid,quantity,quantity).first.price
    # @printprice = PrintMethod.all.find(methodid).print_method_block_size_relations.where("block_size_id = ? AND ? <= end_quantity AND ? >= start_quantity",sizeid,quantity,quantity).first.price
    # @printblockcharge = PrintMethod.all.find(methodid).print_method_block_size_relations.where("block_size_id = ? AND ? <= end_quantity AND ? >= start_quantity",sizeid,quantity,quantity).first.block_charge_price
    @printprice = PrintMethod.all.showprice(methodid,sizeid,quantity)
    @printblockcharge = PrintMethod.all.showblockcharge(methodid,sizeid,quantity)
    @price = @shirtprice+@printprice+(@printblockcharge*noblock.to_i)
  end

  def showcost(shirtid,fitid,methodid,sizeid,quantity,noblock)
    @shirtprice = ShirtType.all.find(shirtid).shirt_type_fit_relations.where("fit_id = ? AND ?<= end_quantity AND ?>=start_quantity",fitid,quantity,quantity).first.price
    @printprice = PrintMethod.all.find(methodid).print_method_block_size_relations.where("block_size_id = ? AND ? <= end_quantity AND ? >= start_quantity",sizeid,quantity,quantity).first.price
    @printblockcharge = PrintMethod.all.find(methodid).print_method_block_size_relations.where("block_size_id = ? AND ? <= end_quantity AND ? >= start_quantity",sizeid,quantity,quantity).first.block_charge_price
    @cost = (@shirtprice+@printprice+(@printblockcharge*noblock.to_i))*quantity.to_i
  end

  def update_total_cost(id)
      quotation = Quotation.find(id)
      actual_price = quotation.actual_price_cents
      quantity = quotation.quantity
      rush_order_fee = quotation.rush_fee_cents
      delivery_fee = quotation.delivery_fee_cents
      additional_price = AdditionalInfo.new.additional_info_price(id)

      # if(!quotation.additional_infos.blank?)
      #   quotation.additional_infos do |additional_info|
      #     if(!additional_info.approval_id.blank?)
      #       additional_price = additional_price + additional_info.price_cents
      #     end
      #   end
      # end
      total_cost = actual_price*quantity+additional_price+rush_order_fee+delivery_fee
      quotation.update(total_cost_cents:total_cost)
  end

  def set_currency_to_sgd!
    self.currency = "SGD"
  end

  def set_currency_to_myr!
    self.currency = "MYR"
  end
  def store_exchange_rate
    self.exchange_rate = ConversionRate.last.exchange_rate
  end
end
