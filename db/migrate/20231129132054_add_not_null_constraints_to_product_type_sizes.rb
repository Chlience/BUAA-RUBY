class AddNotNullConstraintsToProductTypeSizes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :product_type_sizes, :size, false
  end
end
