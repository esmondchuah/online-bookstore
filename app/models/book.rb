class Book < ApplicationRecord
  include Filterable

  has_many :manifests
  has_many :carts
  has_many :orders, through: :manifests
  has_many :opinions

  validates :title, :authors, :publisher, :format, :subject, presence: true
  validates :isbn,      presence: true, uniqueness: true, format: { with: /\A[0-9-]+\z/, message: "only allows numerical digits and hyphens" }, length: { in: 13..14 }
  validates :year,      presence: true, numericality: { only_integer: true }
  validates :inventory, presence: true, numericality: { only_integer: true }
  validates :price,     presence: true, numericality: true

  scope :title,     -> (title)     { where("lower(title) like ?", "%#{title.downcase}%") }
  scope :authors,   -> (authors)   { where("lower(authors) like ?", "%#{authors.downcase}%") }
  scope :publisher, -> (publisher) { where("lower(publisher) like ?", "%#{publisher.downcase}%") }
  scope :subject,   -> (subject)   { where("lower(subject) like ?", "%#{subject.downcase}%") }
  scope :from_this_month, lambda { where("orders.created_at > ? AND orders.created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month) }
end
