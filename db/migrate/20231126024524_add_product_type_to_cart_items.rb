class AddProductTypeToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :product_type, null: false, foreign_key: true
  end
end
