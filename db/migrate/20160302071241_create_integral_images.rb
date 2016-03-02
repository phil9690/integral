class CreateIntegralImages < ActiveRecord::Migration
  def change
    create_table :integral_images do |t|
      t.string :title
      t.string :description
      t.string :file
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
