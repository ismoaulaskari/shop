class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :user
  validates_presence_of :paymethod, :name, :address, :zip, :city, :country, :phone, :email, :unless => "!skip_validations.nil?"
  validates_length_of :name, :phone, :email, :minimum => 6, :unless => "!skip_validations.nil?"
  validates_format_of :email, :with => /.+@.+\..+/i, :unless => "!skip_validations.nil?"
  validates_acceptance_of :terms_of_service, :message => "Säännöt on hyväksyttävä", :unless => "!skip_validations.nil?"
  validates_associated :order_items, :unless => "!skip_validations.nil?"

  attr_accessor :skip_validations
  attr_protected :skip_validations

  def order_total_sum
    @order_items = OrderItem.all(:conditions => { :order_id => self.id })
    @sum = 0
    unless @order_items.nil?
      @order_items.each do |o|
        @sum += (o.item_salesprice * o.amount)
      end  
    end
    self.sum = @sum
  end  
end
