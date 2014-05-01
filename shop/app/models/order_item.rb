class OrderItem < ActiveRecord::Base
  belongs_to :items
  belongs_to :orders
  validates_presence_of :order_id,:item_id
  attr_accessible :order_id,:item_id

  def to_s
    @item = Item.find(self.item_id)
    "##{self.order_id}: ##{self.item_id} #{@item.name} x #{self.amount}, #{self.item_salesprice * self.amount}"
  end
end
