class Sale < ActiveRecord::Migration
  def change
     create_table :sale do |t|
      t.column :cashier_id,:integer
      t.column :customer_id,:integer
    end
  end
end
