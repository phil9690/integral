class AddMenuItemTypes < ActiveRecord::Migration
  def change
    add_column :integral_menu_items, :type, :integer, default: 0
    add_column :integral_menu_items, :object_type, :integer, default: 0
    add_column :integral_menu_items, :object_id, :integer, default: 0
  end
end
