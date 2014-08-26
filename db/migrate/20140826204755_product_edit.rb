class ProductEdit < ActiveRecord::Migration
  def change
    remove_column :cashiers, :pin , :integer
    remove_column :products, :cashier_id , :integer
  end
end
