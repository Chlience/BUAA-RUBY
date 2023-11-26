require "test_helper"

class ProductTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get product_type_show_url
    assert_response :success
  end
end
