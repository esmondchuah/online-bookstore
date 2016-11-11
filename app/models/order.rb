class Order < ApplicationRecord
  belongs_to :user
  has_many :manifests
  has_many :books, through: :manifests
end
