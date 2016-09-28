class AddExtraAttributesToMenuItems < ActiveRecord::Migration
  def change
    add_column :integral_menu_items, :locked, :boolean
    add_column :integral_menu_items, :html_classes, :string
    add_column :integral_menu_items, :description, :text
  end
end
