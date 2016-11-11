class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.timestamps
    end

    add_reference   :orders, :user,  index: true
    add_foreign_key :orders, :users, on_delete: :cascade

    create_table :manifests, id: false do |t|
      t.integer :number_of_copies
    end

    add_reference   :manifests, :order,  index: true
    add_foreign_key :manifests, :orders, on_delete: :cascade

    add_reference   :manifests, :book,   index: true
    add_foreign_key :manifests, :books,  on_delete: :cascade
  end
end