class AddColumn < ActiveRecord::Migration
  def change
    add_column :products, :cashier_id, :integer
  end
end
