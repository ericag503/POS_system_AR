class Purchase < ActiveRecord::Migration
  def change
         create_table :purchase do |t|
      t.column :product_id,:integer
      t.column :sale_id,:integer
    end
  end
end
