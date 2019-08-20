require 'test_helper'

class DirectmessageControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get directmessage_new_url
    assert_response :success
  end

end
