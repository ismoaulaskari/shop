class User < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
  has_many :news
end
