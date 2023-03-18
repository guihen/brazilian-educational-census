require "test_helper"

class RacialDiversityByYearControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    valid_year = 2022
    get racial_diversity_by_year_url(valid_year)
    assert_response :success
  end
end
