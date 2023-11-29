require "test_helper"

class ProductTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get colors" do
    get product_types_colors_url
    assert_response :success
  end
end
