class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.decimal :item_salesprice, :precision => 8, :scale => 2
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
