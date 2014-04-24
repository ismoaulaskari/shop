class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :parent
      t.string :description
      t.string :picurl
      t.integer :discount

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
