class AddAverageScoreToOpinions < ActiveRecord::Migration[5.0]
  def change
    add_column :opinions, :average_usefulness, :decimal
  end
end
