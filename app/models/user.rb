class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :opinions
  has_many :ratings

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def cart_count
    $redis.scard "cart#{id}"
  end

  def cart_total_price
    total_price = 0
    get_cart_books.each { |book| total_price += book.price }
    total_price
  end

  def get_cart_books
    cart_ids = $redis.smembers "cart#{id}"
    Book.find(cart_ids)
  end

  def create_order
    orders.create(status: 0)
  end

  def create_opinion(params)
    opinions.create(params)
  end

  def create_rating(usefulness, opinion_id)
    ratings.create(usefulness: usefulness, opinion_id: opinion_id)
  end
end
