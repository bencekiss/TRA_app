require 'test_helper'

class ConfirmationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get confirmation_new_url
    assert_response :success
  end

  test "should get create" do
    get confirmation_create_url
    assert_response :success
  end

end
