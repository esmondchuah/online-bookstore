class Book < ApplicationRecord
  has_many :manifests
  has_many :carts
  has_many :orders, through: :manifests
  has_many :opinions

  validates :title, :authors, :publisher, :format, :subject, presence: true
  validates :isbn,      presence: true, uniqueness: true, format: { with: /\A[0-9-]+\z/, message: "only allows numerical digits and hyphens" }, length: { in: 13..14 }
  validates :year,      presence: true, numericality: { only_integer: true }
  validates :inventory, presence: true, numericality: { only_integer: true }
  validates :price,     presence: true, numericality: true
end
