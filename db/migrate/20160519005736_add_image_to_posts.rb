class AddImageToPosts < ActiveRecord::Migration
  def change
    add_column :integral_posts, :image, :string
  end
end
