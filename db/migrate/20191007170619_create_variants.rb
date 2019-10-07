class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|

      t.integer :shopify_id, index: {unique: true}
      t.string :url
      t.text :options
      t.string :price
      t.boolean :available
      t.string :image_src
      t.string :barcode
      t.string :sku
      t.string :weight
      t.string :weight_unit

      t.integer :product_id

      t.timestamps null: false
    end
  end
end
