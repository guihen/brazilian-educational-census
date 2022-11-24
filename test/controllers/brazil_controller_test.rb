require "test_helper"

class BrazilControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get brazil_show_url
    assert_response :success
  end
end
