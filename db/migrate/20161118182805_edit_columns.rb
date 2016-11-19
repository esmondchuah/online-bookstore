class EditColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :manifests, :number_of_copies, :quantity
    remove_column :orders, :status, :string
    add_column :orders, :status, :integer
  end
end
