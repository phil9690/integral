class CreateIntegralPostViewings < ActiveRecord::Migration
  def change
    create_table :integral_post_viewings do |t|
      t.references :post, index: true, foreign_key: true
      t.string :ip_address

      t.timestamps null: false
    end
  end
end
