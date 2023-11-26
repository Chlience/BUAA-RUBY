require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get mine" do
    get pages_mine_url
    assert_response :success
  end
end
