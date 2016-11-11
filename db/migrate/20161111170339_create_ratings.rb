class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :usefulness
      t.timestamps
    end

    add_reference   :ratings, :user,     index: true
    add_foreign_key :ratings, :users,    on_delete: :cascade

    add_reference   :ratings, :opinion,  index: true
    add_foreign_key :ratings, :opinions, on_delete: :cascade
  end
end
