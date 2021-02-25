require "test_helper"

class GoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get goods_search_url
    assert_response :success
  end
end
