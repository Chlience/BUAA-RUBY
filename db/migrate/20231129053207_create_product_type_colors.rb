class CreateProductTypeColors < ActiveRecord::Migration[7.0]
  def change
    create_table :product_type_colors do |t|
      t.references :product_type, null: false, foreign_key: true
      t.string :color

      t.timestamps
    end
  end
end
