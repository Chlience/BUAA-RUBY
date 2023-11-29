require "test_helper"

class ProductTypeColorsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get product_type_colors_create_url
    assert_response :success
  end
end
