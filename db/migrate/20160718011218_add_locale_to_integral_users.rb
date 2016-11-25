class AddLocaleToIntegralUsers < ActiveRecord::Migration
  def change
    add_column :integral_users, :locale, :string, default: 'en', null: false
  end
end
