class AddUniqueSizeToProductTypeSizes < ActiveRecord::Migration[7.0]
  def change
    add_index :product_type_sizes, [:product_type, :size], unique: true, name: 'unique_size'
  end
end
