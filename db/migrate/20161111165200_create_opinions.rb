class CreateOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :opinions do |t|
      t.integer :score
      t.text    :comment

      t.timestamps
    end

    add_reference   :opinions, :user,  index: true
    add_foreign_key :opinions, :users, on_delete: :cascade

    add_reference   :opinions, :book,  index: true
    add_foreign_key :opinions, :books, on_delete: :cascade
  end
end
