require "test_helper"

class ChangeRoleControllerTest < ActionDispatch::IntegrationTest
  test "should get change_is_admin" do
    get change_role_change_is_admin_url
    assert_response :success
  end
end
