class Book < ApplicationRecord
  has_many :manifests
  has_many :orders, through: :manifests
end
