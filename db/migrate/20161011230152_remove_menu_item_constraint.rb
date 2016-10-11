class RemoveMenuItemConstraint < ActiveRecord::Migration
  def change
    change_column :integral_menu_items, :title, :string, null: true
  end
end
