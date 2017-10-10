class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

    	t.string :program_id
    	t.string :order_id
    	t.string :item_id
    	t.integer :item_price
    	t.integer :quantity
    	t.string :coupon
    	t.boolean :uploaded

      t.timestamps null: false
    end
  end
end
