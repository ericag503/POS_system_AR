class RenameTable < ActiveRecord::Migration
  def change
    rename_table :sale, :sales
    rename_table :purchase, :purchases
  end
end
