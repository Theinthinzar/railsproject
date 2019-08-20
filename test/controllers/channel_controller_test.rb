require 'test_helper'

class ChannelControllerTest < ActionDispatch::IntegrationTest
  test "should get channel1" do
    get channel_channel1_url
    assert_response :success
  end

end
