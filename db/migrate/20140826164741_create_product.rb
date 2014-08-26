class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.column :name,:string
      t.column :price,:money
    end
  end
end
