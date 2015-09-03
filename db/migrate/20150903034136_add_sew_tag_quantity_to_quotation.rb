class AddSewTagQuantityToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :sew_tag_quantity, :integer
  end
end
