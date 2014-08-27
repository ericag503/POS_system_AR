class Sale < ActiveRecord::Base
  belongs_to :cashier
  has_many :products, through: :purchases
end

