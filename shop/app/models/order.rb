class Order < ActiveRecord::Base
  has_many :items
  belongs_to :user
  validates_presence_of :paymethod, :name, :address, :zip, :city, :country, :phone, :email
end
