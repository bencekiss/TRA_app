require 'test_helper'

class AccountSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get account_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get account_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get account_sessions_destroy_url
    assert_response :success
  end

end
