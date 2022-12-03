require "test_helper"

class RacialDiversityByRegionControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get racial_diversity_by_region_url("norte")
    assert_response :success
  end
end
