class Product < ApplicationRecord
  has_many :product_types, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "product_name", "product_url", "updated_at"]
  end
end
