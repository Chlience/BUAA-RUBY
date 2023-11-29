class CreateProductTypeSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :product_type_sizes do |t|
      t.references :product_type, null: false, foreign_key: true
      t.string :size

      t.timestamps
    end
  end
end
