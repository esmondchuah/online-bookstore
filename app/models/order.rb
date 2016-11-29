class Order < ApplicationRecord
  belongs_to :user
  has_many :manifests
  has_many :books, through: :manifests

  def populate_manifests(carts)
    carts.each { |cart| create_manifest(cart.book_id, cart.quantity) }
  end

  def create_manifest(book_id, quantity)
    manifests.create(book_id: book_id, quantity: quantity)
    book = Book.find(book_id)
    book.update(inventory: book.inventory - quantity)
  end
end
