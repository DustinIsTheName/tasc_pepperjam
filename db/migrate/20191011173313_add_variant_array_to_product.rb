class AddVariantArrayToProduct < ActiveRecord::Migration
  def change
    add_column :products, :variants, :text
  end
end
