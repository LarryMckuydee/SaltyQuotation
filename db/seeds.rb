# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



def shirt_type_fit_relation_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)

  for i in 0..json_hash.count-1
    new_record = ShirtTypeFitRelation.new
    new_record.shirt_type_id = json_hash[i]['shirt_type_id']
    new_record.fit_id = json_hash[i]['fit_id']
    new_record.price_cents = json_hash[i]['price_cents']
    new_record.start_quantity = json_hash[i]['start_quantity']
    new_record.end_quantity = json_hash[i]['end_quantity']
    new_record.save
  end
end

def print_method_block_size_relation_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)
  for i in 0..json_hash.count-1
    new_record = PrintMethodBlockSizeRelation.new
    new_record.print_method_id = json_hash[i]['print_method_id']
    new_record.block_size_id = json_hash[i]['block_size_id']
    new_record.price_cents = json_hash[i]['price_cents']
    new_record.block_charge_price_cents = json_hash[i]['block_charge_price_cents']
    new_record.start_quantity = json_hash[i]['start_quantity']
    new_record.end_quantity = json_hash[i]['end_quantity']
    new_record.save
  end
end

def shirt_type_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)
  for i in 0..json_hash.count-1
    new_record = ShirtType.new
    new_record.name = json_hash[i]['name']
    new_record.save
  end
end

def fit_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)
  for i in 0..json_hash.count-1
    new_record = Fit.new
    new_record.name = json_hash[i]['name']
    new_record.save
  end
end

def brand_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)
  for i in 0..json_hash.count-1
    new_record = Brand.new
    new_record.name = json_hash[i]['name']
    new_record.add_on_entitled = json_hash[i]['add_on_entitled']
    new_record.save
  end
end

def block_size_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)
  for i in 0..json_hash.count-1
    new_record = BlockSize.new
    new_record.name = json_hash[i]['name']
    new_record.save
  end
end

def print_method_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)
  for i in 0..json_hash.count-1
    new_record = PrintMethod.new
    new_record.name = json_hash[i]['name']
    new_record.save
  end
end

def relabel_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)

  for i in 0..json_hash.count-1
    new_record = Relabel.new
    new_record.relabel_charge_cents = json_hash[i]['relabel_charge_cents']
    new_record.start_quantity = json_hash[i]['start_quantity']
    new_record.end_quantity = json_hash[i]['end_quantity']
    new_record.save
  end
end

def woven_tag_data(file_destination)
  json_file = File.read(file_destination)
  json_hash = JSON.parse(json_file)

  for i in 0..json_hash.count-1
    new_record = WovenTag.new
    new_record.tag_charge_cents = json_hash[i]['tag_charge_cents']
    new_record.start_quantity = json_hash[i]['start_quantity']
    new_record.end_quantity = json_hash[i]['end_quantity']
    new_record.save
  end
end

shirt_type_fit_relation_data(Rails.root.join('shirt_type_fit_relations.json'))
shirt_type_fit_relation_data(Rails.root.join('shirt_type_fit_relations1.json'))
shirt_type_fit_relation_data(Rails.root.join('shirt_type_fit_relations2.json'))
shirt_type_fit_relation_data(Rails.root.join('shirt_type_fit_relations3.json'))
shirt_type_fit_relation_data(Rails.root.join('shirt_type_fit_relations4.json'))
print_method_block_size_relation_data(Rails.root.join('print_method_block_size_relations.json'))
print_method_block_size_relation_data(Rails.root.join('print_method_block_size_relations1.json'))
shirt_type_data(Rails.root.join('shirt_types.json'))
block_size_data(Rails.root.join('block_sizes.json'))
brand_data(Rails.root.join('brands.json'))
print_method_data(Rails.root.join('print_methods.json'))
relabel_data(Rails.root.join('relabels.json'))
woven_tag_data(Rails.root.join('woven_tags.json'))
fit_data(Rails.root.join('fits.json'))
