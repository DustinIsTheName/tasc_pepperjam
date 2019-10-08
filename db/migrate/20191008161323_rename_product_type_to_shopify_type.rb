class RenameProductTypeToShopifyType < ActiveRecord::Migration
  def change
    rename_column :products, :type, :shopify_type
  end
end
