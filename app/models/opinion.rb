class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :ratings
end
