class AddTimestampsToLists < ActiveRecord::Migration
  def change
    add_timestamps(:integral_lists)
    add_timestamps(:integral_list_items)
  end
end
