class AddSubTitleToMenus < ActiveRecord::Migration
  def change
    add_column :integral_menu_items, :subtitle,  :string
  end
end
