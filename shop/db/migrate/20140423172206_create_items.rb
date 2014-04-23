class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :discount
      t.integer :saldo
      t.string :picurl
      t.datetime :modified

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
