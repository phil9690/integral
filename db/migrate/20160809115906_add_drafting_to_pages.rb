class AddDraftingToPages < ActiveRecord::Migration
  def change
    add_column :integral_pages, :status, :integer, default: 0
  end
end
