class AlterTypeForMenuItems < ActiveRecord::Migration
  def change
    change_column :integral_menu_items, :type,  :string
  end
end
