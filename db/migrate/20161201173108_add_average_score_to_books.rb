class AddAverageScoreToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :average_score, :decimal
  end
end
