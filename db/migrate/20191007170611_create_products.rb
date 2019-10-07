class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.integer :shopify_id, index: {unique: true}
      t.string :title
      t.text :description
      t.string :vendor
      t.text :tags
      t.string :type
      t.text :options
      t.string :featured_image

      t.string :title_tag
      t.text :description_tag

      t.string :google_product_type
      t.string :age_group

      t.string :custom_label_0
      t.string :custom_label_1
      t.string :custom_label_2
      t.string :custom_label_3
      t.string :custom_label_4

      t.integer :collection_id

      t.timestamps null: false
    end
  end
end
