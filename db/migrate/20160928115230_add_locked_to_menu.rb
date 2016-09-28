class AddLockedToMenu < ActiveRecord::Migration
  def change
    add_column :integral_menus, :locked, :boolean
  end
end
