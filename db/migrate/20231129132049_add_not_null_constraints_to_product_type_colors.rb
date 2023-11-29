class AddNotNullConstraintsToProductTypeColors < ActiveRecord::Migration[7.0]
  def change
    change_column_null :product_type_colors, :color, false
  end
end
