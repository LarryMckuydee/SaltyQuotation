json.price @show_price.to_s
json.cost @show_cost.to_s
json.min_rrp @show_min_rrp.to_s
json.max_rrp @show_max_rrp.to_s
#For singapore use
json.exchange_rate @exchange_rate.to_s
json.currency ENV['CURRENCY']
json.price_sg (@show_price/@exchange_rate).to_s
json.cost_sg (@show_cost/@exchange_rate).to_s
json.min_rrp_sg (@show_min_rrp/@exchange_rate).to_s
json.max_rrp_sg (@show_max_rrp/@exchange_rate).to_s
