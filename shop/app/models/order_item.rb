class OrderItem < ActiveRecord::Base
  belongs_to :items
  belongs_to :orders
  validates_presence_of :order_id,:item_id
  attr_accessible :order_id,:item_id
end
