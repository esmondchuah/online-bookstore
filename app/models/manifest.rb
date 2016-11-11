class Manifest < ApplicationRecord
  belongs_to :book
  belongs_to :order
end
