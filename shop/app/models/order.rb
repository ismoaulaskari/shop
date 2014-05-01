class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :user
  validates_presence_of :paymethod, :name, :address, :zip, :city, :country, :phone, :email, :unless => "!skip_validations.nil?"

  attr_accessor :skip_validations
  attr_protected :skip_validations
end
