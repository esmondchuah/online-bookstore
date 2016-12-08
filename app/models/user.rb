class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :opinions
  has_many :ratings
  has_many :carts

  validates :username,           presence: true, uniqueness: true
  validates :full_name,          presence: true
  validates :credit_card_number, presence: true, format: { with: /\A[0-9]+\z/, message: "only allows numerical digits" }, length: { in: 12..19 }
  validates :address,            presence: true
  validates :phone_number,       presence: true, format: { with: /\A\+?[0-9]+\z/, message: "only allows numerical digits" }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def create_cart(params)
    carts.create(params)
  end

  def cart_count
    carts.sum(:quantity)
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
