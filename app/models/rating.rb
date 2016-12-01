class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :opinion

  validates :user, :opinion, presence: true
  validates :usefulness, presence: true, inclusion: { in: (0..2).to_a, message: "%{value} is not a valid score." }

  before_save :check_opinion_owner
  after_save  :update_opinion_average_usefulness

  protected

  def check_opinion_owner
    if user == opinion.user
      raise "User is not allowed to rate his/her own feedback."
    end
  end

  def update_opinion_average_usefulness
    if opinion.average_usefulness.blank?
      opinion.update(average_usefulness: usefulness)
    else
      opinion.update(average_usefulness: opinion.ratings.average("usefulness"))
    end
  end
end
