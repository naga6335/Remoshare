require "test_helper"

class PostPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get post_pages_home_url
    assert_response :success
  end
end
