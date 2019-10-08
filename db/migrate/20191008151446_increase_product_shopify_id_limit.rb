class IncreaseProductShopifyIdLimit < ActiveRecord::Migration
  def change
    change_column :products, :shopify_id, :integer, limit: 8
  end
end
