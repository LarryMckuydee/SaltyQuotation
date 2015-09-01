json.price ceil2(@show_price.to_d,2).to_s
json.cost ceil2(@show_cost.to_d,2).to_s
json.min_rrp ceil2(@show_min_rrp.to_d,2).to_s
json.max_rrp ceil2(@show_max_rrp.to_d,2).to_s
#For singapore use
json.exchange_rate @exchange_rate.to_s
json.currency ENV['CURRENCY']
json.price_sg ceil2((@show_price/@exchange_rate).to_d,2).to_s
json.cost_sg ceil2((@show_cost/@exchange_rate).to_d,2).to_s
json.min_rrp_sg ceil2((@show_min_rrp/@exchange_rate).to_d,2).to_s
json.max_rrp_sg ceil2((@show_max_rrp/@exchange_rate).to_d,2).to_s
