class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :ratings

  validates :user, :book, presence: true
  validates :score, presence: true, inclusion: { in: (0..10).to_a, message: "%{value} is not a valid score." }

  before_create :check_for_existence
  after_save    :update_book_average_score

  protected

  def check_for_existence
    if Opinion.where(user_id: user_id, book_id: book_id).exists?
      raise "Only one feedback per user per book is allowed."
    end
  end

  def update_book_average_score
    if book.average_score.blank?
      book.update(average_score: score)
    else
      book.update(average_score: book.opinions.average("score"))
    end
  end
end
