class Manifest < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :book, :order, presence: true
  validates :quantity, numericality: { only_integer: true }
end
