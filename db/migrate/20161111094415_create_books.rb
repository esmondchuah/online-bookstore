class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string   :isbn,        null: false, default: ""
      t.string   :title
      t.string   :authors
      t.string   :publisher
      t.integer  :year
      t.integer  :inventory
      t.decimal  :price
      t.string   :format
      t.string   :keywords
      t.string   :subject

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end
