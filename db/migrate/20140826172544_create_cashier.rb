class CreateCashier < ActiveRecord::Migration
  def change
    create_table :cashiers do |t|
      t.column :name, :string
      t.column :pin, :integer
    end
  end
end
