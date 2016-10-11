class AddHtmlAttributesToMenus < ActiveRecord::Migration
  def change
    add_column :integral_menus, :html_classes, :string
    add_column :integral_menus, :html_id, :string
  end
end
