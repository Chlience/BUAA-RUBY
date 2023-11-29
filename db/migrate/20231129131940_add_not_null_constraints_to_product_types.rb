class AddNotNullConstraintsToProductTypes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :product_types, :product_type_name, false
    change_column_null :product_types, :price, false
  end
end
