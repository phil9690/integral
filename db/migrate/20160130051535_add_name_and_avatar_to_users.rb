class AddNameAndAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :integral_users, :name, :string
    add_column :integral_users, :avatar, :string
  end
end
