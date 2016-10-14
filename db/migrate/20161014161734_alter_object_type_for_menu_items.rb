class AlterObjectTypeForMenuItems < ActiveRecord::Migration
  def change
    change_column :integral_menu_items, :object_type,  :string
  end
end
