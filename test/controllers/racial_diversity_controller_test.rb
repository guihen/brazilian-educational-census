require "test_helper"

class RacialDiversityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get racial_diversity_index_url
    assert_response :success
  end
end
