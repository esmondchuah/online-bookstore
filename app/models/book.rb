class Book < ApplicationRecord
  has_many :manifests
  has_many :orders, through: :manifests
  has_many :opinions

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end
end
