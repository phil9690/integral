class AddMenus < ActiveRecord::Migration
  def change
    create_table :integral_menus do |t|
      t.string    "title", :null => false
      t.text      "description"
    end

    create_table "integral_menu_items", :force => true do |t|
      t.string  "title", :null => false
      t.string  "url"
      t.integer  "image_id"
      t.string  "target"
      t.integer "menu_id"
      t.integer "priority"
    end

    create_table "integral_menu_item_connections", :force => true, :id => false do |t|
      t.integer "parent_id", :null => false
      t.integer "child_id", :null => false
    end
  end
end
