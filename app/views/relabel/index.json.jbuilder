json.exchange_rate @exchange_rate.to_s
json.currency ENV['CURRENCY']
json.relabels @relabels do |relabel|
  json.relabel_charge relabel.relabel_charge.to_s
  json.relabel_charge_sg (relabel.relabel_charge/@exchange_rate).to_s
  json.start_quantity relabel.start_quantity
  json.end_quantity relabel.end_quantity
end

json.woven_tags @woven_tags do |woven_tag|
  json.woven_tag_charge woven_tag.tag_charge.to_s
  json.woven_tag_charge_sg (woven_tag.tag_charge/@exchange_rate).to_s
  json.start_quantity woven_tag.start_quantity
  json.end_quantity woven_tag.end_quantity
end
