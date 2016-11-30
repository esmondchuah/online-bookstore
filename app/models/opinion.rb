class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :ratings

  validates :score, :user, :book, presence: true

  before_save :check_for_existence

  protected

  def check_for_existence
    if Opinion.where(user_id: user_id, book_id: book_id).exists?
      raise "Only one feedback per user per book is allowed."
    end
  end
end
