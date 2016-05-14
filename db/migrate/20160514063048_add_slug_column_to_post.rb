class AddSlugColumnToPost < ActiveRecord::Migration
  def change
    add_column :integral_posts, :slug, :string
    add_index :integral_posts, :slug, unique: true
  end
end
