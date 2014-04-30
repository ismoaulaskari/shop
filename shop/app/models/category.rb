class Category < ActiveRecord::Base
  has_many :items
  validates_presence_of :name

  def to_s
  #  "#{Brewery.find_by(id:self.brewery_id).name} :  #{self.name}"
    "#{name}"
  end
end
