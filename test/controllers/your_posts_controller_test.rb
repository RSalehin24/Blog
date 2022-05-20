require "test_helper"

class YourPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get get_posts" do
    get your_posts_get_posts_url
    assert_response :success
  end
end
