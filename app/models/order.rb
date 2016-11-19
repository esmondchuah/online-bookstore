class Order < ApplicationRecord
  belongs_to :user
  has_many :manifests
  has_many :books, through: :manifests

  def populate_manifests(books)
    books.each { |book| create_manifest(book.id) }
  end

  def create_manifest(book_id)
    manifests.create(book_id: book_id, quantity: 1)
  end
end