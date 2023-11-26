require "test_helper"

class PageControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get page_main_url
    assert_response :success
  end
end
