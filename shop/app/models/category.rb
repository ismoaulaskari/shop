class Category < ActiveRecord::Base
  has_many :items
  validates_presence_of :name

  def to_s
    "#{name}"
  end
end
