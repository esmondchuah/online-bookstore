class Cart < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book, :user, presence: true
  validates :quantity, numericality: { only_integer: true }
end
