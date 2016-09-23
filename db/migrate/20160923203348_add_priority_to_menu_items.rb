class AddPriorityToMenuItems < ActiveRecord::Migration
  def change
    add_column :integral_menu_items, :priority, :integer
  end
end
