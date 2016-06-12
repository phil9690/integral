class AddDraftingToPosts < ActiveRecord::Migration
  def change
    add_column :integral_posts, :published_at, :date
    add_column :integral_posts, :status, :integer, default: 0
  end
end
