class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts, id: false do |t|
      t.integer :quantity
    end

    add_reference   :carts, :user,  index: true
    add_foreign_key :carts, :users, on_delete: :cascade

    add_reference   :carts, :book,   index: true
    add_foreign_key :carts, :books,  on_delete: :cascade
  end
end
