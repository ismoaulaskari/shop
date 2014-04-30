class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :description
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :discount
      t.integer :saldo
      t.string :picurl
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
