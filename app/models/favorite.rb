class Favorite < ApplicationRecord
  belongs_to :favorite_user, class_name: "User", foreign_key: "user_id"
  belongs_to :favorite_product, class_name: "Product", foreign_key: "product_id"
end
