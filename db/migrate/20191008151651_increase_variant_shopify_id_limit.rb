class IncreaseVariantShopifyIdLimit < ActiveRecord::Migration
  def change
    change_column :variants, :shopify_id, :integer, limit: 8
  end
end
