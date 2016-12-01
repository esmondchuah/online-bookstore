class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :opinion

  validates :usefulness, :user, :opinion, presence: true

  before_save :check_opinion_owner

  protected

  def check_opinion_owner
    if user == opinion.user
      raise "User is not allowed to rate his/her own feedback."
    end
  end
end
