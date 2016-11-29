class Book < ApplicationRecord
  has_many :manifests
  has_many :carts
  has_many :orders, through: :manifests
  has_many :opinions
end
