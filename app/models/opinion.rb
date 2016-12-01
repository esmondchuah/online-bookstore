class Opinion < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :ratings

  validates :score, :user, :book, presence: true

  before_save :check_for_existence
  after_save  :update_book_average_score

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
