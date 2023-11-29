class AddUniqueColorToProductTypeColors < ActiveRecord::Migration[7.0]
  def change
    add_index :product_type_colors, [:product_type, :color], unique: true, name: 'unique_color'
  end
end
