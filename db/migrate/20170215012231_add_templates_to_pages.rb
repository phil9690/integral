class AddTemplatesToPages < ActiveRecord::Migration
  def change
    add_column :integral_pages, :template, :string, default: 'default'
  end
end
