class Item < ActiveRecord::Base
  has_many :order_items
  belongs_to :category
  validates_presence_of :name, :description, :price, :saldo
end
