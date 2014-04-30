class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :sum
      t.string :paymethod
      t.string :name
      t.string :address
      t.string :zip
      t.string :city
      t.string :country
      t.string :phone
      t.string :email
      t.string :notes
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
