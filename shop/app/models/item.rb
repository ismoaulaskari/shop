class Item < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :name, :description, :price, :saldo
end
