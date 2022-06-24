require "test_helper"

class ChatUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get chat_users_show_url
    assert_response :success
  end
end
